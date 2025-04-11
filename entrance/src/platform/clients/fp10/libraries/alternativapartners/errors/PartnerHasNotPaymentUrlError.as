package platform.clients.fp10.libraries.alternativapartners.errors {
  public class PartnerHasNotPaymentUrlError extends Error {
    public function PartnerHasNotPaymentUrlError(param1:Object) {
      super();
      message = "Partner hasn\'t payment URL. Partner: " + param1;
    }
  }
}
