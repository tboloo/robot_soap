from zeep import Client
import json

class CustomerServiceLibrary(object):
	"""docstring for CustomerServiceLibrary"""
	def __init__(self):
		super(CustomerServiceLibrary, self).__init__()
		self.wsdl = 'http://www.predic8.com:8080/crm/CustomerService?wsdl'
		self.client = Client(self.wsdl)
		self.factory = self.client.type_factory('ns2')
		self.factory_ns1 = self.client.type_factory('ns1')

	def create_customer(self, id):
		"""Creates new customer"""
		address = self.factory.AddressType('5th Avenue','New York', '90210','USA')
		person = self.factory.PersonType(1,'John', 'Doe', address, 39)
		customer = self.factory_ns1.CustomerType(person,address,id)
		result = self.client.service.create(customer)
		if result is None:
			return 'ok'
		else:
			return result

	def get_customer(self, id):
		"""Gets customer by id"""
		result = self.client.service.get(id)
		return result

	def get_all_customers(self):
		"""Checkout"""
