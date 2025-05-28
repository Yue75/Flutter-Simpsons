import { Router } from "express";

const router = Router();

/**
 * Route principale pour les opérations UPDATE
 * Cette route servira de point d'entrée pour toutes les opérations de mise à jour
 */
router.put("/", (req, res) => {
  res.json({ message: "UPDATE route working" });
});

export default router;
