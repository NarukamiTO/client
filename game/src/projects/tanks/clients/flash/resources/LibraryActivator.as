package projects.tanks.clients.flash.resources {
  import alternativa.osgi.OSGi;
  import projects.tanks.clients.flash.resources.osgi.Activator;

  public class LibraryActivator {
    [Inject]
    public var osgi:OSGi;

    private var classicActivator:Activator;

    public function LibraryActivator() {
      super();
    }

    [PostConstruct]
    public function activate() : void {
      this.classicActivator = new Activator();
      this.classicActivator.start(this.osgi);
    }
  }
}
