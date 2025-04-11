package utils.preview {
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ImageResourceLoadingWrapper implements IResourceLoadingListener {
    private var previewModel:IImageResource;

    public function ImageResourceLoadingWrapper(param1:IImageResource) {
      super();
      this.previewModel = param1;
    }

    public function onResourceLoadingStart(param1:Resource) : void {
    }

    public function onResourceLoadingProgress(param1:Resource, param2:int) : void {
    }

    public function onResourceLoadingComplete(param1:Resource) : void {
      this.previewModel.setPreviewResource(ImageResource(param1));
    }

    public function onResourceLoadingError(param1:Resource, param2:String) : void {
      throw new Error("Ошибка загрузки ресурса (id: " + param1.id + ")");
    }

    public function onResourceLoadingFatalError(param1:Resource, param2:String) : void {
      throw new Error("Ошибка загрузки ресурса (id: " + param1.id + ")");
    }
  }
}
