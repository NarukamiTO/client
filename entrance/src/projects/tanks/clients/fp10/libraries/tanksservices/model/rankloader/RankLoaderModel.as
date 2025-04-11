package projects.tanks.clients.fp10.libraries.tanksservices.model.rankloader {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.tanksservices.model.rankloader.IRankLoaderModelBase;
  import projects.tanks.client.tanksservices.model.rankloader.RankLoaderModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;

  [ModelInfo]
  public class RankLoaderModel extends RankLoaderModelBase implements IRankLoaderModelBase, ObjectLoadListener {
    [Inject]
    public static var rankService:RankService;

    public function RankLoaderModel() {
      super();
    }

    public function objectLoaded() : void {
      rankService.initRanks(getInitParam().ranks);
    }
  }
}
