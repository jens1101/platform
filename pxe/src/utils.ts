import { Effect, pipe } from "effect";
import { type Response } from "express";

export const endpointWrapper =
  ({
    defectMessage,
    res,
    status = 500,
  }: {
    defectMessage: string;
    res: Response;
    status?: number;
  }) =>
  <A, E>(effect: Effect.Effect<A, E>) =>
    pipe(
      effect,
      Effect.tapErrorCause((cause) => Effect.logError(defectMessage, cause)),
      Effect.catchAllCause(() =>
        Effect.sync(() => {
          res.status(status);
          res.send({ error: defectMessage });
        }),
      ),
      Effect.runPromise,
    );
