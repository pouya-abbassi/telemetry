#include <drogon/drogon.h>

#include <fstream>
#include <iostream>

using namespace drogon;

int main() {
  app().registerHandler(
      "/",
      [](const HttpRequestPtr &req,
         std::function<void(const HttpResponsePtr &)> &&callback) {
        auto resp = HttpResponse::newHttpResponse();

        std::ofstream out;
        out.open("/tmp/telemetry.txt", std::ios_base::app);
        auto body = req->getBody().data();
        std::cout << body << std::endl;
        out << body << std::endl;
        out.close();

        resp->setBody("Hello, World!");
        callback(resp);
      },
      {Get, Post});

  app()
      .setLogPath("./")
      .setLogLevel(trantor::Logger::kWarn)
      .addListener("0.0.0.0", 6070)
      .setThreadNum(16)
      // .enableRunAsDaemon()
      .run();
}
