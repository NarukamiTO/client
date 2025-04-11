package alternativa.tanks.gui.friends {
  public class RejectAllIncomingButton extends FriendWindowButton implements IRejectAllIncomingButtonEnabled {
    public function RejectAllIncomingButton() {
      super();
    }

    public function setEnable(param1:Boolean) : void {
      super.enable = param1;
    }
  }
}
