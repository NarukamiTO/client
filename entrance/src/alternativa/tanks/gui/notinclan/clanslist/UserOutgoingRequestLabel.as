package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;

  public class UserOutgoingRequestLabel extends ClanInfoLabel {
    public function UserOutgoingRequestLabel(param1:Long) {
      super(param1);
    }

    override protected function onCancelClick(param1:MouseEvent) : void {
      cancelIndicator.visible = false;
      var local2:IGameObject = clanUserService.getObjectById(clanId);
      (clanUserService.userObject.adapt(IClanUserModel) as IClanUserModel).revoke(local2);
    }

    override public function showIndicators() : void {
      super.showIndicators();
    }
  }
}
