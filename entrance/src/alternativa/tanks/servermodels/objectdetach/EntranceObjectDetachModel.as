package alternativa.tanks.servermodels.objectdetach {
  import alternativa.tanks.loader.ILoaderWindowService;
  import projects.tanks.client.entrance.model.entrance.objectdetach.EntranceObjectDetachModelBase;
  import projects.tanks.client.entrance.model.entrance.objectdetach.IEntranceObjectDetachModelBase;

  [ModelInfo]
  public class EntranceObjectDetachModel extends EntranceObjectDetachModelBase implements IEntranceObjectDetachModelBase {
    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    public function EntranceObjectDetachModel() {
      super();
    }

    public function objectDetach() : void {
      loaderWindowService.show();
    }
  }
}
