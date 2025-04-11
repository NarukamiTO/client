package projects.tanks.clients.flash.resources.osgi {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.types.Long;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import projects.tanks.clients.flash.resources.resource.MapResource;
  import projects.tanks.clients.flash.resources.resource.PropLibResource;
  import projects.tanks.clients.flash.resources.resource.RawDataResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Activator implements IBundleActivator {
    public var resourceRegistry:ResourceRegistry;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      this.resourceRegistry = ResourceRegistry(param1.getService(ResourceRegistry));
      this.resourceRegistry.registerTypeClasses(MapResource.TYPE,MapResource);
      this.resourceRegistry.registerTypeClasses(PropLibResource.TYPE,PropLibResource);
      this.resourceRegistry.registerTypeClasses(Tanks3DSResource.TYPE,Tanks3DSResource);
      this.resourceRegistry.registerTypeClasses(RawDataResource.TYPE,RawDataResource);
    }

    public function stop(param1:OSGi) : void {
      this.resourceRegistry.unregisterResource(Long(PropLibResource.TYPE));
      this.resourceRegistry.unregisterResource(Long(MapResource.TYPE));
    }
  }
}
