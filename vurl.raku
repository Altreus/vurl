#!raku

use API::Discord;

sub MAIN(Str $token) {
    my $discord = API::Discord.new(:$token);

    $discord.connect;
    await $discord.ready;

    # hard-coded for now
    my $announcements = $discord.get-channel(271281782152757248);

    react {
        whenever $discord.messages -> $m {
            if $m.channel ~~ $announcements and $m.content !~~ / "https://" / {
                $m.delete;
                $announcements.send-message(':b4nzyblob: No chatting! Links only!');
            }
        }
    }
}
