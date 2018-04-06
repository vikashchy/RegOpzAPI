from Helpers.DatabaseHelper import DatabaseHelper
from Models.UserPermission import UserPermission
import uuid
from datetime import datetime, timedelta
from jwt import JWT, jwk_from_pem
from flask import request
from Constants.Status import *

TokenKey = 'HTTP_AUTHORIZATION'

class Token(object):
	def __init__(self,tenant_info):
		self.tenant_info=tenant_info
		self.dbhelper = DatabaseHelper(self.tenant_info)
		if TokenKey in request.environ:
			self.token = request.environ[TokenKey]

	def create(self, user):
		user_id = user['name']
		firstname = user['first_name']
		role = user['role']
		try:
			self.tokenId = self.get(user_id)
		except ValueError:
			self.tokenId = str(uuid.uuid4())
			self.lease_start = datetime.now()
			self.lease_end = self.lease_start + timedelta(hours=24)
			self.ip = request.remote_addr
			self.user_agent = request.headers.get('User-Agent')
			self.user_id = user_id
			queryString = "INSERT INTO token(token, lease_start, lease_end, ip, user_agent, user_id) VALUES (%s,%s,%s,%s,%s,%s)"
			values = (self.tokenId, self.lease_start, self.lease_end, self.ip, self.user_agent, self.user_id, )
			try:
				rowid = self.dbhelper.transact(queryString, values)
			except Exception:
				return NO_USER_FOUND
		user_permission = UserPermission(self.tenant_info).get(role)
		if user_permission:
			user = {
				'tokenId': self.tokenId,
				'userId': user_id,
				'name': firstname,
				'role': user_permission['role'],
				'permission': user_permission['components']
			}
			jwtObject = JWT()
			with open('private_key', 'rb') as fh:
				salt = jwk_from_pem(fh.read())
			jwt = jwtObject.encode(user, salt, 'RS256')
			return jwt
		else:
			return { "msg": "Permission Denied" },301

	def get(self, userId):
		queryString = "SELECT token FROM token WHERE user_id=%s and lease_end > %s"
		queryParams = (userId, datetime.now(), )
		cur = self.dbhelper.query(queryString, queryParams)
		data = cur.fetchone()
		if data:
			return data['token']
		else:
			raise ValueError("User not logged in!")

	def authenticate(self, auth=None):
		token = auth if auth else self.token
		if token:
			extracted_token = token.replace("Bearer ", "")
			with open('public_key', 'r') as fh:
				salt = jwk_from_pem(fh.read().encode())
			try:
				token_decode = JWT().decode(extracted_token, salt)
			except Exception:
				raise TypeError("Invalid Token Recieved for Authentication")
			queryString = "SELECT user_id FROM token WHERE token=%s AND user_id=%s AND lease_end > %s"
			queryParams = (token_decode['tokenId'], token_decode['userId'], datetime.now(), )
			cur = self.dbhelper.query(queryString, queryParams)
			data = cur.fetchone()
			if data:
				return data['user_id']
			else:
				raise ValueError("Invalid Credentials Recieved for Authentication")
		else:
			raise ValueError("Token Not Found for Authentication")
