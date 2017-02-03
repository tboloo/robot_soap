from zeep import Client

class CurrencyConverterServiceLibrary(object):
	"""Library for wrapping calls to http://www.webservicex.net/ currency converter service"""
	def __init__(self):
		super(CurrencyConverterServiceLibrary, self).__init__()
		self.wsdl = 'http://www.webservicex.net/CurrencyConvertor.asmx?WSDL'
		self.client = Client(self.wsdl)
		self.result = ''

	def get_conversion_rate(self, fromCurrency, toCurrency):
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
