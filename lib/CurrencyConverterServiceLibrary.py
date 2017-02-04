from zeep import Client
import sys

class CurrencyConverterServiceLibrary(object):
	"""Library for wrapping calls to http://www.webservicex.net/ currency converter service"""
	def __init__(self):
		super(CurrencyConverterServiceLibrary, self).__init__()
		self.wsdl = 'http://www.webservicex.net/CurrencyConvertor.asmx?WSDL'
		self.client = Client(self.wsdl)
		self.result = ''

	def get_conversion_rate(self, fromCurrency, toCurrency):
		"""Gets the conversion rate for the pair of currencies"""
		try:
			self.result = self.client.service.ConversionRate(fromCurrency, toCurrency)
		except Exception as e:
			self.result = str(e)

	def result_should_be(self, expected):
		"""Verifies that the current result is ``expected``.

        Example:
        | Get Conversion Rate  | USD |  PLN |
        | Result Should Be | 4,01       |
        """
		if self.result != expected:
			raise AssertionError('%s != %s' % (self.result, expected))

	def get_available_currencies(self):
		raise NotImplementedError(sys._getframe().f_code.co_name)