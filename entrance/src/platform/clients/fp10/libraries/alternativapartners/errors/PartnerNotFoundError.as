package platform.clients.fp10.libraries.alternativapartners.errors {
  public class PartnerNotFoundError extends Error {
    public function PartnerNotFoundError(param1:String) {
      super();
      message = "Partner not found. Partner id: " + param1;
    }
  }
}
