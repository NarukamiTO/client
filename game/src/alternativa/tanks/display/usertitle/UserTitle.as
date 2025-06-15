package alternativa.tanks.display.usertitle {
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.display.resistance.ResistanceShieldIcon;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.utils.MathUtils;
  import controls.Label;
  import controls.base.LabelBase;
  import filters.Filters;
  import flash.display.BitmapData;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.geom.Vector3D;
  import flash.text.GridFitType;
  import flash.text.TextFieldAutoSize;
  import flash.utils.getTimer;
  import forms.ColorConstants;
  import forms.ranks.SmallRankIcon;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class UserTitle implements AutoClosable {
    private static const matrix:Matrix = new Matrix();
    private static const RANK_ICON_SIZE:int = 13;
    private static const RANK_ICON_OFFSET_Y:int = 3;
    private static const PREMIUM_RANK_ICON_OFFSET_Y:int = 0;
    private static const PREMIUM_RANK_ICON_SIZE:int = 18;
    private static const LABEL_HEIGHT:int = 13;
    private static const RESISTANCE_ICON_WIDTH:int = 11;
    private static const RESISTANCE_ICON_SPACING_X:int = 7;
    private static const RESISTANCE_MAX_TEXT_WIDTH:int = 10;
    private static const EFFECTS_ICON_SIZE:int = 18;
    private static const LABEL_SPACING:int = 2;
    private static const HEALTH_BAR_SPACING_Y:int = 2;
    private static const WEAPON_BAR_SPACING_Y:int = -1;
    private static const EFFECTS_SPACING_Y:int = 4;
    private static const EFFECTS_SPACING_X:int = 4;
    private static const BAR_WIDTH:int = 100;
    private static const BAR_HEIGHT:int = 8;
    private static const TEXTURE_MARGIN:int = 3;
    private static const TEXTURE_MARGIN_2:int = 2 * TEXTURE_MARGIN;
    private static const rankIcon:SmallRankIcon = new SmallRankIcon();
    private static const inventoryItemTypes:Vector.<int> = Vector.<int>([InventoryItemType.ULTIMATE,InventoryItemType.FIRST_AID,InventoryItemType.ARMOR,InventoryItemType.DAMAGE,InventoryItemType.NITRO]);

    public static const ALPHA_SPEED:Number = 0.002;

    public static var showAddition:Boolean = false;

    private var configFlags:int;
    private var dirtyFlags:int;
    private var sprite:Sprite3D;
    private var textureRect:Rectangle;
    private var label:Label;
    private var healthBar:ProgressBar;
    private var weaponBar:ProgressBar;
    private var effectIndicators:Vector.<EffectIndicator>;
    private var numVisibleIndicators:int;
    private var effectIndicatorsY:int;
    private var rankId:int;
    private var labelText:String;
    private var health:int;
    private var weaponStatus:int;
    private var indicatorsNeedsReset:Boolean;
    private var teamType:BattleTeam = BattleTeam.NONE;
    private var healthBarSkin:ProgressBarSkin = ProgressBarSkin.HEALTHBAR_DM;
    private var isSuspicious:Boolean;
    private var hidden:Boolean = true;
    private var time:int;
    private var material:TextureMaterial;
    private var texture:BitmapData;
    private var zOffset:Number;
    private var container:Scene3DContainer;
    private var resistanceLabel:Label = new LabelBase();
    private var size:Size2D = new Size2D();
    private var maxHealth:int;
    private var isLocal:Boolean;
    private var hasPremium:Boolean;
    private var resistance:int;
    private var additionUserTitle:AdditionUserTitle;
    private var tankObject:IGameObject;

    public function UserTitle(param1:Number, param2:Scene3DContainer, param3:int, param4:Boolean, param5:IGameObject = null) {
      super();
      this.zOffset = param1;
      this.container = param2;
      this.maxHealth = param3;
      this.isLocal = param4;
      this.tankObject = param5;
      this.material = new TextureMaterial();
      this.material.uploadEveryFrame = true;
      this.sprite = new Sprite3D(100,100,this.material);
      if(param1 == 0) {
        this.sprite.depthTest = false;
      }
      this.sprite.clipping = Clipping.FACE_CLIPPING;
      this.sprite.perspectiveScale = false;
      this.sprite.alpha = 0;
      this.sprite.visible = false;
      this.sprite.useShadowMap = false;
      this.sprite.useLight = false;
      if(!param4) {
        this.sprite.originY = 1;
        this.additionUserTitle = new AdditionUserTitle();
      }
      this.hidden = true;
    }

    private function updateAdditionalUserTitle(param1:uint) : void {
      if(!this.isLocal) {
        this.additionUserTitle.updateTexture(param1,this.tankObject,this.sprite.height);
      }
    }

    public function updateInfo() : void {
      if(!this.isLocal) {
        this.additionUserTitle.updateTexture(this.healthBarSkin.color,this.tankObject,this.sprite.height);
      }
    }

    public function getTexture() : BitmapData {
      return this.texture;
    }

    public function hide() : void {
      this.hidden = true;
    }

    public function show() : void {
      this.hidden = false;
    }

    private function setConfiguration(param1:int) : void {
      if(this.configFlags != param1) {
        this.configFlags = param1;
        this.updateTitle();
      }
    }

    public function setConfigurationFlags(param1:int, param2:Boolean) : void {
      if(param2) {
        this.setConfiguration(this.configFlags | param1);
      } else {
        this.setConfiguration(this.configFlags & ~param1);
      }
    }

    private function updateTitle() : void {
      this.invalidateConfigFlags(TitleConfigFlags.EFFECTS | TitleConfigFlags.HEALTH | TitleConfigFlags.WEAPON);
      this.indicatorsNeedsReset = true;
      this.updateConfiguration();
    }

    public function setResistance(param1:int) : void {
      if(this.resistance != param1) {
        this.resistance = param1;
        this.resistanceLabel.text = param1.toString();
        this.invalidateAllConfigFlags();
      }
    }

    public function getResistance() : int {
      return this.resistance;
    }

    public function setTeamType(param1:BattleTeam) : void {
      var local2:ProgressBarSkin = null;
      if(this.teamType != param1) {
        this.teamType = param1;
        local2 = ProgressBarSkin.getHealthBarSkin(param1);
        if(this.healthBarSkin.color != local2.color) {
          this.updateAdditionalUserTitle(local2.color);
        }
        this.healthBarSkin = local2;
        this.invalidateConfigFlags(TitleConfigFlags.LABEL | TitleConfigFlags.HEALTH | TitleConfigFlags.WEAPON);
      }
    }

    public function setRank(param1:int) : void {
      if(this.rankId != param1) {
        this.rankId = param1;
        if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
          this.invalidateAllConfigFlags();
        }
      }
    }

    private function invalidateAllConfigFlags() : void {
      this.invalidateConfigFlags(TitleConfigFlags.LABEL | TitleConfigFlags.ANY_HEALTH | TitleConfigFlags.WEAPON | TitleConfigFlags.EFFECTS);
    }

    public function setPremium(param1:Boolean) : void {
      if(this.hasPremium != param1) {
        this.hasPremium = param1;
        if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
          this.invalidateAllConfigFlags();
        }
      }
    }

    public function setLabelText(param1:String) : void {
      if(this.labelText != param1) {
        this.labelText = param1;
        if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
          this.updateConfiguration();
          this.invalidateAllConfigFlags();
        }
      }
    }

    public function setHealth(param1:int) : void {
      if(this.health != param1) {
        this.health = param1;
        this.invalidateConfigFlags(TitleConfigFlags.ANY_HEALTH);
      }
    }

    public function setWeaponStatus(param1:int) : void {
      if(this.weaponStatus != param1) {
        this.weaponStatus = param1;
        this.invalidateConfigFlags(TitleConfigFlags.WEAPON);
      }
    }

    public function showIndicator(param1:int, param2:int = -1, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void {
      var local6:EffectIndicator = null;
      if(this.hasAnyFlag(TitleConfigFlags.EFFECTS)) {
        local6 = this.getEffectIndicatorById(param1);
        if(local6 != null) {
          if(local6.isHidden()) {
            this.changeVisibleIndicatorsNumber(1);
          }
          if(param5) {
            local6.showInfinite();
          } else {
            local6.show(param2,param3,param4);
          }
        }
      }
    }

    public function hideIndicator(param1:int, param2:Boolean = false) : void {
      var local3:EffectIndicator = null;
      if(this.hasAnyFlag(TitleConfigFlags.EFFECTS)) {
        local3 = this.getEffectIndicatorById(param1);
        if(local3 != null) {
          if(param2) {
            local3.activeAfterDeath = false;
          }
          local3.hide();
        }
      }
    }

    public function hideIndicators() : void {
      var local1:int = 0;
      if(this.hasAnyFlag(TitleConfigFlags.EFFECTS) && this.effectIndicators != null) {
        for each(local1 in inventoryItemTypes) {
          this.hideIndicator(local1);
        }
      }
    }

    internal function doHideIndicator(param1:EffectIndicator) : void {
      param1.clear(this.texture);
      this.changeVisibleIndicatorsNumber(-1);
    }

    public function update(param1:Vector3) : void {
      var local4:EffectIndicator = null;
      this.setPosition(param1);
      var local2:int = getTimer();
      var local3:int = local2 - this.time;
      this.time = local2;
      this.updateVisibility(local3);
      if(this.dirtyFlags != 0) {
        if(this.hasDirtyConfigFlags(TitleConfigFlags.LABEL)) {
          this.updateLabel();
        }
        if(this.hasDirtyConfigFlags(TitleConfigFlags.ANY_HEALTH)) {
          this.healthBar.setSkin(this.healthBarSkin);
          this.healthBar.progress = this.health;
          this.healthBar.draw(this.texture);
        }
        if(this.hasDirtyConfigFlags(TitleConfigFlags.WEAPON)) {
          this.weaponBar.progress = this.weaponStatus;
          this.weaponBar.draw(this.texture);
        }
        if(this.hasDirtyConfigFlags(TitleConfigFlags.EFFECTS)) {
          for each(local4 in this.effectIndicators) {
            local4.forceRedraw();
          }
        }
        this.dirtyFlags = 0;
      }
      if(this.hasAnyFlag(TitleConfigFlags.EFFECTS)) {
        this.updateEffectIndicators(local2,local3);
        if(this.healthBar != null && this.hasAnyFlag(TitleConfigFlags.ANY_HEALTH)) {
          this.healthBar.draw(this.texture);
        }
      }
    }

    private function hasDirtyConfigFlags(param1:int) : Boolean {
      return (param1 & this.dirtyFlags & this.configFlags) != 0;
    }

    private function updateEffectIndicators(param1:int, param2:int) : void {
      var local3:EffectIndicator = null;
      var local4:int = 0;
      var local6:int = 0;
      var local5:int = int(this.effectIndicators.length);
      if(this.indicatorsNeedsReset) {
        this.indicatorsNeedsReset = false;
        local6 = this.size.width + TEXTURE_MARGIN_2 - this.numVisibleIndicators * EFFECTS_ICON_SIZE - (this.numVisibleIndicators - 1) * EFFECTS_SPACING_X >> 1;
        local4 = 0;
        while(local4 < local5) {
          local3 = this.effectIndicators[local4];
          if(local3.isVisible()) {
            local3.clear(this.texture);
          }
          if(!local3.isHidden()) {
            local3.setPosition(local6,this.effectIndicatorsY);
            local6 += EFFECTS_ICON_SIZE + EFFECTS_SPACING_X;
          }
          local4++;
        }
        this.invalidateConfigFlags(TitleConfigFlags.HEALTH);
      }
      local4 = 0;
      while(local4 < local5) {
        local3 = this.effectIndicators[local4];
        local3.update(param1,param2,this.texture);
        local4++;
      }
    }

    private function changeVisibleIndicatorsNumber(param1:int) : void {
      this.numVisibleIndicators += param1;
      this.indicatorsNeedsReset = true;
    }

    private function updateConfiguration() : void {
      if(this.configFlags != 0) {
        this.setupTexture();
        this.setupComponents();
      }
    }

    private function setupTexture() : void {
      var local1:int = 0;
      var local2:int = 0;
      this.size.setToZero();
      if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
        this.createLabelComponents();
        // Narukami ext-color-names - use HTML text for label
        this.label.htmlText = this.labelText || "";
        this.resistanceLabel.color = MessageColor.YELLOW;
        this.resistanceLabel.filters = Filters.SHADOW_FILTERS;
        this.size.setWidth(PREMIUM_RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth + RESISTANCE_ICON_SPACING_X + RESISTANCE_ICON_WIDTH + RESISTANCE_MAX_TEXT_WIDTH);
        this.size.setHeight(LABEL_HEIGHT);
      }
      if(this.hasAnyFlag(TitleConfigFlags.ANY_HEALTH)) {
        this.size.setWidthIfGreater(BAR_WIDTH);
        if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
          this.size.addHeight(HEALTH_BAR_SPACING_Y);
        }
        this.size.addHeight(BAR_HEIGHT);
        if(this.hasAnyFlag(TitleConfigFlags.WEAPON)) {
          this.size.addHeight(WEAPON_BAR_SPACING_Y + BAR_HEIGHT);
        }
      }
      if(this.hasAnyFlag(TitleConfigFlags.EFFECTS)) {
        local1 = 4;
        local2 = local1 * EFFECTS_ICON_SIZE + (local1 - 1) * EFFECTS_SPACING_X;
        this.size.setWidthIfGreater(local2);
        if(this.hasAnyFlag(TitleConfigFlags.LABEL | TitleConfigFlags.ANY_HEALTH)) {
          this.size.addHeight(EFFECTS_SPACING_Y);
        }
        this.size.addHeight(EFFECTS_ICON_SIZE);
      }
      this.size.addWidth(2 * TEXTURE_MARGIN);
      this.size.addHeight(2 * TEXTURE_MARGIN);
      this.createTexture();
      this.updateAdditionalUserTitle(this.healthBarSkin.color);
    }

    private function createTexture() : void {
      var local1:int = Math.ceil(this.size.width);
      var local2:int = Math.ceil(this.size.height);
      var local3:int = MathUtils.nearestPowerOf2(this.size.width);
      var local4:int = MathUtils.nearestPowerOf2(this.size.height);
      var local5:Boolean = false;
      if(this.texture == null || this.texture.width != local3 || this.texture.height != local4) {
        if(this.texture != null) {
          this.texture.dispose();
        }
        this.texture = new BitmapData(local3,local4,true,0);
        this.material.texture = this.texture;
        this.textureRect = this.texture.rect;
        local5 = true;
      }
      if(local5 || local1 != this.sprite.width || local2 != this.sprite.height) {
        this.sprite.width = local1;
        this.sprite.height = local2;
        this.sprite.bottomRightU = local1 / local3;
        this.sprite.bottomRightV = local2 / local4;
        this.invalidateAllConfigFlags();
      }
    }

    private function setupComponents() : void {
      var local2:int = 0;
      var local1:int = TEXTURE_MARGIN;
      if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
        local1 += LABEL_HEIGHT;
      }
      if(this.hasAnyFlag(TitleConfigFlags.ANY_HEALTH)) {
        if(this.hasAnyFlag(TitleConfigFlags.LABEL)) {
          local1 += HEALTH_BAR_SPACING_Y;
        }
        local2 = this.size.width - BAR_WIDTH >> 1;
        this.healthBar = new ProgressBar(local2,local1,this.maxHealth,BAR_WIDTH,this.healthBarSkin);
        local1 += BAR_HEIGHT;
        if(this.hasAnyFlag(TitleConfigFlags.WEAPON)) {
          local1 += WEAPON_BAR_SPACING_Y;
          this.weaponBar = new ProgressBar(local2,local1,100,BAR_WIDTH,ProgressBarSkin.WEAPONBAR);
          local1 += BAR_HEIGHT;
        }
      }
      if(this.hasAnyFlag(TitleConfigFlags.EFFECTS)) {
        local1 += EFFECTS_SPACING_Y;
        this.effectIndicatorsY = local1;
        this.createEffectsIndicators();
      }
    }

    public function addToContainer() : void {
      this.container.addChild(this.sprite);
      if(this.additionUserTitle != null) {
        this.container.addChild(this.additionUserTitle);
      }
      this.time = getTimer();
    }

    public function removeFromContainer() : void {
      this.container.removeChild(this.sprite);
      if(this.additionUserTitle != null) {
        this.container.removeChild(this.additionUserTitle);
      }
    }

    private function setPosition(param1:Vector3) : void {
      this.sprite.x = param1.x;
      this.sprite.y = param1.y;
      this.sprite.z = param1.z + this.zOffset;
      if(!this.isLocal) {
        this.additionUserTitle.x = this.sprite.x;
        this.additionUserTitle.y = this.sprite.y;
        this.additionUserTitle.z = this.sprite.z;
      }
    }

    public function readPosition(param1:Vector3D) : void {
      param1.x = this.sprite.x;
      param1.y = this.sprite.y;
      param1.z = this.sprite.z;
    }

    public function setSuspicious(param1:Boolean) : void {
      this.isSuspicious = param1;
      this.invalidateAllConfigFlags();
    }

    private function invalidateConfigFlags(param1:int) : void {
      this.dirtyFlags |= param1;
    }

    public function hasAnyFlag(param1:int) : Boolean {
      return (param1 & this.configFlags) != 0;
    }

    private function createLabelComponents() : void {
      if(this.label == null) {
        this.label = new Label();
        this.label.gridFitType = GridFitType.PIXEL;
        this.label.autoSize = TextFieldAutoSize.LEFT;
        this.label.thickness = 200;
      }
    }

    private function updateLabel() : void {
      var local1:BitmapData = this.texture.clone();
      local1.fillRect(this.textureRect,0);
      var local2:int = this.getRankIconSize() + LABEL_SPACING + this.label.textWidth;
      if(this.resistance > 0) {
        local2 += RESISTANCE_ICON_SPACING_X + Math.max(RESISTANCE_ICON_WIDTH,this.resistanceLabel.textWidth);
      }
      var local3:int = this.size.width - local2 >> 1;
      matrix.tx = local3;
      matrix.ty = TEXTURE_MARGIN + this.getRankIconOffsetY();
      rankIcon.init(this.hasPremium,this.rankId);
      local1.draw(rankIcon,matrix,null,null,null,true);
      matrix.tx = local3 + this.getRankIconSize() + LABEL_SPACING;
      matrix.ty = TEXTURE_MARGIN;
      // Narukami ext-color-names - disable client-side colorization if label contains HTML tags
      if(this.labelText.indexOf("<") == -1) {
        this.label.textColor = this.isSuspicious ? uint(ColorConstants.SUSPICIOUS) : this.healthBarSkin.color;
      }
      local1.draw(this.label,matrix,null,null,null,true);
      if(this.resistance > 0) {
        matrix.tx += RESISTANCE_ICON_SPACING_X + this.label.textWidth;
        matrix.ty = TEXTURE_MARGIN + 4;
        local1.draw(ResistanceShieldIcon.getBitmap(this.teamType),matrix,null,null,null,true);
      }
      this.texture.applyFilter(local1,this.textureRect,new Point(),Filters.SHADOW_FILTER);
      if(this.resistance > 0) {
        matrix.tx += 3;
        matrix.ty = TEXTURE_MARGIN;
        this.texture.draw(this.resistanceLabel,matrix,null,null,null,true);
      }
      local1.dispose();
    }

    private function createEffectsIndicators() : void {
      var local1:int = 0;
      if(this.effectIndicators == null) {
        this.effectIndicators = new Vector.<EffectIndicator>();
        for each(local1 in inventoryItemTypes) {
          this.effectIndicators.push(new EffectIndicator(local1,this));
        }
      }
    }

    private function getEffectIndicatorById(param1:int) : EffectIndicator {
      var local2:int = 0;
      var local3:int = 0;
      var local4:EffectIndicator = null;
      if(this.effectIndicators != null) {
        local2 = int(this.effectIndicators.length);
        local3 = 0;
        while(local3 < local2) {
          local4 = this.effectIndicators[local3];
          if(local4.effectId == param1) {
            return local4;
          }
          local3++;
        }
      }
      return null;
    }

    private function updateVisibility(param1:int) : void {
      if(this.hidden) {
        if(this.sprite.alpha > 0) {
          this.sprite.alpha -= ALPHA_SPEED * param1;
          if(this.sprite.alpha <= 0) {
            this.sprite.alpha = 0;
            this.sprite.visible = false;
          }
        }
      } else {
        this.sprite.visible = true;
        if(this.sprite.alpha < 1) {
          this.sprite.alpha += ALPHA_SPEED * param1;
          if(this.sprite.alpha > 1) {
            this.sprite.alpha = 1;
          }
        }
      }
      if(this.additionUserTitle != null) {
        if(Boolean(this.sprite.visible) && showAddition) {
          this.additionUserTitle.visible = true;
          if(this.additionUserTitle.alpha < 1) {
            this.additionUserTitle.alpha += ALPHA_SPEED * param1 * 2.3;
          }
        } else if(this.additionUserTitle.alpha > 0) {
          this.additionUserTitle.alpha -= ALPHA_SPEED * param1 * 2.3;
        }
        if(this.sprite.alpha < this.additionUserTitle.alpha) {
          this.additionUserTitle.alpha = this.sprite.alpha;
        }
        if(!this.sprite.visible) {
          this.additionUserTitle.visible = false;
          this.additionUserTitle.alpha = 0;
        }
      }
    }

    private function getRankIconSize() : int {
      return this.hasPremium ? PREMIUM_RANK_ICON_SIZE : RANK_ICON_SIZE;
    }

    private function getRankIconOffsetY() : int {
      return this.hasPremium ? PREMIUM_RANK_ICON_OFFSET_Y : RANK_ICON_OFFSET_Y;
    }

    public function close() : void {
      if(this.additionUserTitle != null) {
        this.additionUserTitle.dispose();
        this.additionUserTitle = null;
      }
      if(this.material != null) {
        this.material.dispose();
        this.material = null;
      }
      if(this.texture != null) {
        this.texture.dispose();
        this.texture = null;
      }
      if(this.sprite != null) {
        this.sprite.material = null;
      }
      this.sprite = null;
      this.container = null;
      this.tankObject = null;
    }
  }
}
