package alternativa.tanks.models.user.accepted {
  import alternativa.types.Long;
  import projects.tanks.client.clans.user.accepted.ClanUserAcceptedModelBase;
  import projects.tanks.client.clans.user.accepted.IClanUserAcceptedModelBase;

  [ModelInfo]
  public class ClanUserAcceptedModel extends ClanUserAcceptedModelBase implements IClanUserAcceptedModelBase {
    public function ClanUserAcceptedModel() {
      super();
    }

    public function onAdding(param1:Long) : void {
    }

    public function onRemoved(param1:Long) : void {
    }
  }
}
