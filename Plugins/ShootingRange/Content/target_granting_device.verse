
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

target_granting_device := class(creative_device):
    
    @editable Target : shooting_range_target_device = shooting_range_target_device{}
    @editable Trigger : trigger_device = trigger_device{}
    @editable Granter : item_granter_device = item_granter_device{}

    OnBegin<override>()<suspends>:void=
        Trigger.TriggeredEvent.Subscribe(Hit)

    Hit(MaybeAgent:?agent):void=
        if (Agent := agent[MaybeAgent?]):
            Target.PopDown()
            AwardPlayer(Agent)
            spawn:
                PopUp()
            
    AwardPlayer(Agent:agent):void=
        Granter.GrantItem(Agent)

    PopUp()<suspends>:void=
        Sleep(2.0)
        Target.PopUp()
