#########################################################################
#  OpenKore - Packet sending
#  This module contains functions for sending packets to the server.
#
#  This software is open source, licensed under the GNU General Public
#  License, version 2.
#  Basically, this means that you're allowed to modify and distribute
#  this software. However, if you distribute modified versions, you MUST
#  also distribute the source code.
#  See http://www.gnu.org/licenses/gpl.html for the full license.
########################################################################
#bysctnightcore
package Network::Send::kRO::RagexeRE_2017_12_27a;

use strict;
use base qw(Network::Send::kRO::RagexeRE_2017_12_20a);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);
	
	my %packets = (
		'0361' => ['actor_action', 'a4 C', [qw(targetID type)]],
		'0802' => ['actor_info_request', 'a4', [qw(ID)]],
		'0369' => ['actor_look_at', 'v C', [qw(head body)]],
		'0368' => ['actor_name_request', 'a4', [qw(ID)]],
		'0811' => ['buy_bulk_buyer', 'a4 a4 a*', [qw(buyerID buyingStoreID itemInfo)]], #Buying store
		'0817' => ['buy_bulk_closeShop'],			
		'0815' => ['buy_bulk_openShop', 'a4 c a*', [qw(limitZeny result itemInfo)]], #Selling store
		'0360' => ['buy_bulk_request', 'a4', [qw(ID)]], #6
		'0437' => ['character_move', 'a3', [qw(coordString)]],
		'0946' => ['friend_request', 'a*', [qw(username)]],# len 26
		'08A5' => ['homunculus_command', 'v C', [qw(commandType, commandID)]],
		'0969' => ['item_drop', 'a2 v', [qw(ID amount)]],
		'0945' => ['item_list_window_selected', 'v V V a*', [qw(len type act itemInfo)]],
		'088D' => ['item_take', 'a4', [qw(ID)]],
		'092C' => ['map_login', 'a4 a4 a4 V C', [qw(accountID charID sessionID tick sex)]],
		'0938' => ['party_join_request_by_name', 'Z24', [qw(partyName)]],
		'083C' => ['skill_use', 'v2 a4', [qw(lv skillID targetID)]],
		'0438' => ['skill_use_location', 'v4', [qw(lv skillID x y)]],
		'08A0' => ['storage_item_add', 'a2 V', [qw(ID amount)]],
		'0888' => ['storage_item_remove', 'a2 V', [qw(ID amount)]],
		'087D' => ['storage_password'],
		'035F' => ['sync', 'V', [qw(time)]],		
	);
	
	$self->{packet_list}{$_} = $packets{$_} for keys %packets;
	
	my %handlers = qw(
		actor_action 0361
		actor_info_request 0802
		actor_look_at 0369
		actor_name_request 0368
		buy_bulk_buyer 0811
		buy_bulk_closeShop 0817
		buy_bulk_openShop 0815
		buy_bulk_request 0360
		character_move 0437
		friend_request 0946
		homunculus_command 08A5
		item_drop 0969
		item_list_window_selected 0945
		item_take 088D
		map_login 092C
		party_join_request_by_name 0938
		skill_use 083C
		skill_use_location 0438
		storage_item_add 08A0
		storage_item_remove 0888
		storage_password 087D
		sync 035F
	);
	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;
	
	return $self;
}

1;