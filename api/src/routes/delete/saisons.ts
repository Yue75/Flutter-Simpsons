import { Router } from "express";

const router = Router();

/**
 * Route principale pour les opérations DELETE
 * Cette route servira de point d'entrée pour toutes les opérations de suppression
 */
router.delete("/", (req, res) => {
  res.json({ message: "DELETE route working" });
});

export default router;
