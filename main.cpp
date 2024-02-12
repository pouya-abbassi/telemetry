#include <drogon/drogon.h>
using namespace drogon;

int main() {
  app().registerHandler(
      "/",
      [](const HttpRequestPtr &,
         std::function<void(const HttpResponsePtr &)> &&callback) {
        auto resp = HttpResponse::newHttpResponse();
        resp->setBody("Hello, World!");
        callback(resp);
      },
      {Get});

  app()
      .setLogPath("./")
      .setLogLevel(trantor::Logger::kWarn)
      .addListener("0.0.0.0", 6070)
      .setThreadNum(16)
      // .enableRunAsDaemon()
      .run();
}
