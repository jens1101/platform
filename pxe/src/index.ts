import { endpointWrapper } from "./utils.ts";
import { Effect, pipe } from "effect";
import express from "express";
import Handlebars from "handlebars";
import path from "node:path";

const app = express();

app.get("/user-data", (_req, res) =>
  pipe(
    // TODO: get the user data file here instead
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
  res.download(path.join(import.meta.dirname, "boot.ipxe"));
});

app.listen(80);
