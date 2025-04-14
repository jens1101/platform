import { endpointWrapper } from "./utils.ts";
import { Effect, pipe } from "effect";
import express from "express";
import Handlebars from "handlebars";

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

app.use("/iso", express.static(process.env.ISO_MOUNT_PATH));

app.listen(process.env.PORT);
