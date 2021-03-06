import phoenix from 'phoenix';

const { Presence, Socket } = phoenix;
export const connect = ({ username, channel_topic }) => {
  let lastSeenId = 0;

  // Connect to the socket
  let socket = new Socket('/socket', {
    params: {
      last_seen_id: lastSeenId,
      username,
    },
  });
  socket.connect();

  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(channel_topic, {});
  channel
    .join()
    .receive('ok', (resp) => {
      console.log('Joined successfully', resp);
    })
    .receive('error', (resp) => {
      console.log('Unable to join', resp);
    });

  let presence = new Presence(channel);

  return { socket, channel, presence };
};
