{
  services.thelounge = {
    enable = true;
    port = 9000;

    extraConfig = {
      # host = undefined;
      reverseProxy = true;
      theme="morning";
      prefetch = true;
      prefetchMaxImageSize=30720; # kb

      # file upload
      fileUpload = {
	enable = true;
	maxFileSize = 5120; # kb
	# baseUrl needs reverse-proxy configured, else set to null
	baseUrl = null;
      };

      # default settings
      defaults = {
        name = "Rizon IRC";
        host = "irc.rizon.net";
        port = 6697;
        tls = true;
        rejectUnauthorized = true;
        nick = "Mizu25";
        username = "Mizu-hayate";
        realname = "Mizu";
        join = "#nanoha";
      };
    };
  };
}
