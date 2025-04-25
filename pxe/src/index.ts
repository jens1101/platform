import { endpointWrapper } from "./utils.ts";
import { Effect, pipe } from "effect";
import express from "express";
import Handlebars from "handlebars";
import path from "node:path";

const app = express();

// TODO: remove this
app.get("/user-data", (_req, res) =>
  pipe(
    Effect.try(() => Handlebars.compile<{ name: string }>("Name: {{name}}")),
    Effect.andThen((template) => {
      res.send(template({ name: "Jens" }));
    }),
    endpointWrapper({
      defectMessage: "Failed to get user data",
      res,
    }),
  ),
);

app.get("/", (_req, res) => {
  res.download(process.env.NETBOOT_IPXE_PATH);
});

app.get("/kernel", (_req, res) => {
  res.download(process.env.KERNEL_PATH);
});

app.get("/initrd", (_req, res) => {
  res.download(process.env.INITRD_PATH);
});

app.listen(80);
