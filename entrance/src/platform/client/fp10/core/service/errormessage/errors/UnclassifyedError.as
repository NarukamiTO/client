package platform.client.fp10.core.service.errormessage.errors {
  public class UnclassifyedError implements ErrorType {
    private var message:String;

    public function UnclassifyedError(param1:String) {
      super();
      this.message = param1;
    }

    public function getMessage() : String {
      return this.message;
    }
  }
}
