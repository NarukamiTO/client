package alternativa.osgi.bundle {
  import alternativa.utils.Properties;

  public interface IBundleDescriptor {
    function get name() : String;
    function get activators() : Vector.<IBundleActivator>;
    function get properties() : Properties;
  }
}
