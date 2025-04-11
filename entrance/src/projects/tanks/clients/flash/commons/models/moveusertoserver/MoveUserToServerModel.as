package projects.tanks.clients.flash.commons.models.moveusertoserver {
  import projects.tanks.client.commons.models.moveusertoclient.IMoveUserToServerModelBase;
  import projects.tanks.client.commons.models.moveusertoclient.MoveUserToServerModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;

  [ModelInfo]
  public class MoveUserToServerModel extends MoveUserToServerModelBase implements IMoveUserToServerModelBase {
    [Inject]
    public static var addressService:TanksAddressService;

    public function MoveUserToServerModel() {
      super();
    }

    public function move(param1:int) : void {
      addressService.setServer(param1);
    }
  }
}
