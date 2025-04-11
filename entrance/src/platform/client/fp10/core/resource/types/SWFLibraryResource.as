package platform.client.fp10.core.resource.types {
  import platform.client.fp10.core.resource.ILockableResource;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceInfo;

  public class SWFLibraryResource extends Resource implements ILockableResource {
    public function SWFLibraryResource(param1:ResourceInfo) {
      super(param1);
    }

    override public function get description() : String {
      return "Library";
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      completeLoading();
    }

    public function unlockResourceLoading() : void {
      completeLoading();
    }
  }
}
