
chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block mychannel.tx
rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
# cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME="ChannelBank"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile ChannelBank -configPath . -outputCreateChannelTx ./ChannelBank.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for Bank1MSP  ##########"
configtxgen -profile ChannelBank -configPath . -outputAnchorPeersUpdate ./Bank1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Bank1MSP

echo "#######    Generating anchor peer update for Bank2MSP  ##########"
configtxgen -profile ChannelBank -configPath . -outputAnchorPeersUpdate ./Bank2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Bank2MSP


CUSTOM_CHANNEL="ChannelCBDC"

# Generate channel configuration block
configtxgen -profile ChannelCBDC -configPath . -outputCreateChannelTx ./ChannelCBDC.tx -channelID $CUSTOM_CHANNEL

echo "#######    Generating anchor peer update for NonbankMSP  ##########"
configtxgen -profile ChannelCBDC -configPath . -outputAnchorPeersUpdate ./NonbankMSPanchors.tx -channelID $CUSTOM_CHANNEL -asOrg NonbankMSP