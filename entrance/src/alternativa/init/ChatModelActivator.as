package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.tanks.gui.communication.tabs.chat.ChatTabView;
  import alternativa.tanks.gui.communication.tabs.chat.IChatTabView;
  import alternativa.tanks.services.NewsService;
  import alternativa.tanks.services.NewsServiceImpl;

  public class ChatModelActivator implements IBundleActivator {
    public function ChatModelActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      param1.registerService(NewsService,new NewsServiceImpl());
      param1.registerService(IChatTabView,new ChatTabView());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
