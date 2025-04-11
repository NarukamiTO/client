package alternativa.tanks.model.videoadvertisement {
  import projects.tanks.client.panel.model.videoads.videoadsbattleresult.IVideoAdsBattleResultModelBase;
  import projects.tanks.client.panel.model.videoads.videoadsbattleresult.VideoAdsBattleResultModelBase;

  [ModelInfo]
  public class VideoAdsBattleResultModel extends VideoAdsBattleResultModelBase implements IVideoAdsBattleResultModelBase {
    public function VideoAdsBattleResultModel() {
      super();
    }

    public function availableIncreasedRewards(param1:int) : void {
    }

    public function availableSimpleRewards(param1:int) : void {
    }

    public function notAvailableRewards() : void {
    }
  }
}
