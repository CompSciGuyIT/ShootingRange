
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }
using { /UnrealEngine.com/Temporary/Diagnostics }

spawner : class(tag){}

game_manager := class(creative_device):

    @editable Button : button_device = button_device{}
    @editable Granter : item_granter_device = item_granter_device{}

    var CustomPlayers : [player]custom_player = map{}

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(GiveItem)

        GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerLeftServer)

    InitSpawners():void=
        Spawners := GetCreativeObjectsWithTag(spawners{})
        for (Obj : Spawners):
            if (Spawner := player_spawner_device[Obj]):
                Spawner.SpawnedEvent.Subscribe(OnPlayerSpawned)

    OnPlayerSpawned(Agent:agent):void=
        if (Player := player[Agent]):
            InitPlayer(Player)

    InitPlayer(Player:player):void=
        if (Existing := CustomPlayers[Player]) {}
        else:
            if (FortChar := Player.GetFortCharacter[]):
                FortChar.EliminatedEvent().Subscribe(OnPlayerEliminated)
                CustomPlayer := custom_player{ Player := Player }
                if (set CustomPlayers[Player] = CustomPlayer) {}

    OnPlayerEliminated(Result : elimination_result):void=
        if:
            Eliminator := Result.EliminatedCharacter?
            Agent := Eliminator.GetAgent[]
            Player := player[Agent]
            CustomPlayer := CustomPlayers[Player]      
        then:
            # Check that player didn't kill themselves
            if (not (Result.EliminatedCharacter = Result.EliminatingCharacter?)):
                CustomPlayer.AwardElimination()

    OnPlayerLeftServer(PlayerLeaving:player):void=
        if (CustomPlayer := CustomPlayers[PlayerLeaving]):
            var NewPlayerMap : [player]custom_player = map{}
            for (Key => Value : CustomPlayers, Key <> CustomPlayer):
                set NewPlayerMap = ConcatenateMaps(NewPlayerMap, map{ Key => Value })
            set CustomPlayers = NewPlayerMap

    GiveItem(Agent:agent):void=
        Granter.GrantItem(Agent)