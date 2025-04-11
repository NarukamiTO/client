package platform.client.fp10.core.resource.types {
  import alternativa.osgi.service.locale.ILocaleService;
  import platform.client.fp10.core.resource.ResourceInfo;

  public class LocalizedImageResource extends ImageResource {
    [Inject]
    public static var localeService:ILocaleService;

    public function LocalizedImageResource(param1:ResourceInfo) {
      super(param1);
    }

    override protected function getImageFileName() : String {
      return localeService.language.toLowerCase() + ".tnk";
    }
  }
}
