package classes.UIComponents.ContentModules 
{
	import classes.UIComponents.ContentModule;
	import fl.controls.UIScrollBar;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import classes.UIComponents.UIStyleSettings;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class MailModule extends ContentModule
	{
		private var _mailText:TextField;
		private var _scrollBar:UIScrollBar;
		private var _mailTree:MailTree;
		
		public function get htmlText():String { return _mailText.htmlText; }
		public function set htmlText(v:String):void { _mailText.htmlText = v; }
		
		public function MailModule() 
		{
			leftBarEnabled = true;
			rightBarEnabled = false;
			fullButtonTrayEnabled = true;
			_moduleName = "MailDisplay";
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Build();
			BuildTree();
		}
		
		private function Build():void
		{
			_mailText = new TextField();
			_mailText.border = false;
			_mailText.background = false;
			_mailText.multiline = true;
			_mailText.wordWrap = true;
			_mailText.embedFonts = true;
			_mailText.antiAliasType = AntiAliasType.ADVANCED;
			_mailText.x = 5;
			_mailText.y = 5;
			_mailText.height = 735;
			_mailText.width = 774;
			_mailText.styleSheet = UIStyleSettings.gMainTextCSSStyleSheet;
			_mailText.name = _moduleName+"text";
			_mailText.htmlText = "<span class='words'><p>Syncing smutbuffer... preparing waifusbase... reticulating horsecocks... DONE\n\n> I am mailbox. Please insert dragon dongs.</p></span>";
			addChild(_mailText);
			
			_mailText.addEventListener(Event.SCROLL, updateScrollBar);
			
			_scrollBar = new UIScrollBar();
			_scrollBar.direction = "vertical";
			_scrollBar.setSize(_mailText.width, _mailText.height + 5);
			_scrollBar.move(_mailText.x + _mailText.width, 0);
			addChild(_scrollBar);
			_scrollBar.scrollTarget = _mailText;
		}
		
		private function updateScrollBar(e:Event):void
		{
			_scrollBar.update();
		}
		
		private function BuildTree():void
		{
			_mailTree = new MailTree();
			_mailTree.x = _mailText.x + _mailText.width + 21;
			addChild(_mailTree);
		}
		
		public override function hiddenFromStage():void
		{
			_mailTree.hiddenFromStage();
		}
		
		public function update():void
		{
			_mailTree.update();
		}
	}
}