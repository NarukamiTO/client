package projects.tanks.clients.fp10.libraries.tanksservices.service.address.types {
  public class ServerNameParts {
    private var serverNumber:int;
    private var valid:Boolean;

    public function ServerNameParts(param1:Boolean, param2:int = 0) {
      super();
      this.valid = param1;
      this.serverNumber = param2;
    }

    public function isValid() : Boolean {
      return this.valid;
    }

    public function getServerNumber() : int {
      return this.serverNumber;
    }
  }
}
