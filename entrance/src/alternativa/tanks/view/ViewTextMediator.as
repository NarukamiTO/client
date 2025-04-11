package alternativa.tanks.view {
  import alternativa.tanks.view.forms.ViewText;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class ViewTextMediator extends Mediator {
    [Inject]
    public var injector:IInjector;

    [Inject]
    public var view:ViewText;

    public function ViewTextMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
    }
  }
}
