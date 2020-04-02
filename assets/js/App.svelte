<script>
  export let name;
  export let socket;

  let connected = false;

  // Functions
  const sendMessage = ({ name, message }) => {
    channel.push("shout", {
      // send the message to the server on "shout" channel
      name, // get value of "name" of person sending the message
      message // get message text (value) from msg input field.
    });
    msg.value = "";
  };

  const onMessageReceived = ({ name, message }) => {
    console.log("Name: ", name);
    console.log("Message: ", message);
  };

  // // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel("room:lobby", {});
  channel
    .join()
    .receive("ok", resp => {
      console.log("Joined successfully", resp);
      connected = true;
    })
    .receive("error", resp => {
      console.log("Unable to join", resp);
    });
  channel.on("shout", onMessageReceived);


  


</script>

<style>
  h1 {
    color: red;
  }
</style>

<h1>Hello {name}!</h1>
<p>connected {connected}</p>
<input bind:value={name} placeholder="enter your name">