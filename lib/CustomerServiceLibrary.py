from zeep import Client
import json

class CustomerServiceLibrary(object):
	"""docstring for CustomerServiceLibrary"""
	def __init__(self):
		super(CustomerServiceLibrary, self).__init__()
		self.wsdl = 'http://www.predic8.com:8080/crm/CustomerService?wsdl'
		self.client = Client(self.wsdl)
		self.factory = self.client.type_factory('ns2')

	def create_customer(self):
		"""Creates new customer"""
		address = self.factory.AddressType('5th Avenue','New York', '90210','USA')
		person = self.factory.PersonType(1,'John', 'Doe', address, 39)
		customer = self.factory.CustomerType(person,address,1)
		result = self.client.service.create(customer)
		return result

	def get_customer(self, id):
		"""Gets customer by id"""
		result = self.client.service.get(id)
		return result

	def get_all_customers(self):
		"""Checkout"""
