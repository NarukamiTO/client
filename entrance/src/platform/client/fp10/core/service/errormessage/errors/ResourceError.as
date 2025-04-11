package platform.client.fp10.core.service.errormessage.errors {
  import platform.client.fp10.core.resource.Resource;

  public class ResourceError implements ErrorType {
    private var resource:Resource;
    private var errorText:String;

    public function ResourceError(param1:Resource, param2:String) {
      super();
      this.errorText = param2;
      this.resource = param1;
    }

    public function getMessage() : String {
      return "Fatal error. Resource id: " + this.resource.id + ", resource version: " + this.resource.version + " " + this.errorText;
    }
  }
}
