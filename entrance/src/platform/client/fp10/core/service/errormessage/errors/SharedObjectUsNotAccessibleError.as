package platform.client.fp10.core.service.errormessage.errors {
  public class SharedObjectUsNotAccessibleError implements ErrorType {
    public function SharedObjectUsNotAccessibleError() {
      super();
    }

    public function getMessage() : String {
      return "Local SharedObject is not accessible for writing";
    }
  }
}
