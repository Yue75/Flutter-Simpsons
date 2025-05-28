import { Router } from "express";

const router = Router();

router.post("/", async (req, res) => {
  res.json({
    message: "Hello World",
  });
});

export default router;
