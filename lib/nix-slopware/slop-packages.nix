# https://codeberg.org/ethical-foss/open-slopware
let
	tags = {
		vc = "Vibecoded";
		pa = "Permissive AI Policy";
		af = "AI Functionality";
		ac = "AI Code Reviews";
		aa = "Gen AI \"Art\"";
		as = "AI Sponsored";
		ab = "AI Databroker Usage";
		ai = "AI Issue Tracker";
		cl = "Condones LLM ingestion";
	};
in with tags; [
	{
		name = "espeak-ng";
		categories = [ ac pa ];
	}
	{
		name = "beancount";
		categories = [ pa ];
	}
	{
		name = "firefly-iii";
		categories = [ pa ];
	}
	{
		name = "gnucash";
		categories = [ pa ];
	}
	{
		name = "hledger";
		categories = [ pa ];
	}
	{
		name = "kmymoney";
		categories = [ pa ];
	}
	{
		name = "ledger";
		categories = [ pa ];
	}
	{
		name = "surge-xt";
		categories = [ pa ];
	}
	{
		name = "audacity";
		categories = [ af ac pa ];
	}
	{
		name = "ardour";
		categories = [ pa ];
	}
	{
		name = "mixxx";
		categories = [ pa ];
	}
	{
		name = "zrythm";
		categories = [ pa ];
	}
	{
		name = "clementine";
		categories = [ pa ac ];
	}
	{
		name = "fooyin";
		categories = [ pa ac ];
	}
	{
		name = "nuclear";
		categories = [ pa af ];
	}
	{
		name = "strawberry";
		categories = [ pa ac ];
	}
	{
		name = "tauon";
		categories = [ pa ];
	}
	{
		name = "musescore";
		categories = [ pa ac ];
	}
	{
		name = "borgbackup";
		categories = [ pa ];
	}
	#
	{
		name = "rsync";
		categories = [ vc ];
	}
	{
		name = "koreader";
		categories = [ aa ];
	}
	{
		name = "brush";
		categories = [ aa ];
	}
	{
		name = "discourse";
		categories = [ aa ];
	}
	{
		name = "golly";
		categories = [ aa ];
	}
	{
		name = "bun";
		categories = [ vc ];
	}
	{
		name = "gitea";
		categories = [ aa ];
	}
	{
		name = "netbird";
		categories = [ ab ];
	}
]
