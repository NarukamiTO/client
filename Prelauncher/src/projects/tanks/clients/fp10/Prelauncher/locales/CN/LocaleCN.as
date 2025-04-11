package projects.tanks.clients.fp10.Prelauncher.locales.CN {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocaleCN extends Locale {
    public var chinese1:TextLinkPair;
    public var chinese2:TextLinkPair;
    public var chinese3:TextLinkPair;
    public var chinese4:TextLinkPair;
    public var chinese5:TextLinkPair;
    public var chinese6:TextLinkPair;
    public var chinese7:TextLinkPair;
    public var chinese21:TextLinkPair;
    public var chinese22:TextLinkPair;
    public var chinese23:TextLinkPair;
    public var chinese24:TextLinkPair;
    public var chinese25:TextLinkPair;
    public var chinese26:TextLinkPair;
    public var chinese27:TextLinkPair;

    public function LocaleCN() {
      super();
      this.name = Locales.CN;
      this.playText = "PLAY";
      this.exitText = "EXIT";
      this.game = new TextLinkPair("游戏","http://3dtank.com/");
      this.materials = new TextLinkPair("视频图片","http://3dtank.com/media/");
      this.forum = new TextLinkPair("玩家论坛","http://forum.3dtank.com/");
      this.ratings = new TextLinkPair("排行榜","http://ratings.3dtank.com/");
      this.help = new TextLinkPair("使用帮助","http://3dtank.com/help/");
      this.chinese1 = new TextLinkPair("3D坦克版权所有 © 2010","");
      this.chinese2 = new TextLinkPair("沪ICP备13037028号","http://www.miibeian.gov.cn/");
      this.chinese3 = new TextLinkPair("网络文化经营许可证 沪网文【2011】0438-043","");
      this.chinese4 = new TextLinkPair("商务合作：hezuo#3dtank.com （#改为“艾特”）","");
      this.chinese5 = new TextLinkPair("抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。","");
      this.chinese6 = new TextLinkPair("适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。","");
      this.chinese7 = new TextLinkPair("家长监护工程","http://union.3dtank.com/safeguard.html");
      this.chinese21 = new TextLinkPair("服务信息","");
      this.chinese22 = new TextLinkPair("客服QQ：4000519995","");
      this.chinese23 = new TextLinkPair("客服热线：4000519995","");
      this.chinese24 = new TextLinkPair("游戏账号处理邮箱：","");
      this.chinese25 = new TextLinkPair("help@3dtank.com","mailto:help@3dtank.com");
      this.chinese26 = new TextLinkPair("投诉建议邮箱：","");
      this.chinese27 = new TextLinkPair("guanli@3dtank.com","mailto:guanli@3dtank.com");
    }
  }
}
