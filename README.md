# glafs - erlang bittorrent implementation

This is an attempt to make an implementation of the BitTorrent protocol in
Erlang as specified in [BEP3](www.bittorrent.org/beps/bep_0003.html) with
the primary purpose of improving my Erlang competence.

My ambition is that glafs will be a low-dependency (except for Erlang and
perhaps Python) tracker for easily sharing files on i.e. office networks or
LAN-parties.

## Current Status

- [x] Decodes the `bencoding`-format used by `.torrent`-files
[BEP3](www.bittorrent.org/beps/bep_0003.html)
- [ ] Encodes a file with `bencoding` to create a `.torrent`-file
- [ ] Supports Compact Peer Lists 
[BEP23](http://www.bittorrent.org/beps/bep_0023.html)
- [ ] Supports UDP Tracker Protocol
[BEP15](http://www.bittorrent.org/beps/bep_0015.html)
- [ ] Supports enough HTTP for a simple tracker

