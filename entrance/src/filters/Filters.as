package filters {
  import flash.filters.GlowFilter;

  public class Filters {
    public static const SHADOW_FILTER:GlowFilter = new GlowFilter(0,0.8,4,4,3);
    public static const SHADOW_FILTERS:Array = [SHADOW_FILTER];
    public static const SHADOW_ON_OVER_FILTER:GlowFilter = new GlowFilter(0,0.8,4,4,5);
    public static const SHADOW_ON_OVER_FILTERS:Array = [SHADOW_ON_OVER_FILTER];

    public function Filters() {
      super();
    }
  }
}
