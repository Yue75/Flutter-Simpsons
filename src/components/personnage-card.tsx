"use client";

import { Card, CardContent, CardFooter } from "@/components/ui/card";
import Image from "next/image";
import { useRouter } from "next/navigation";

/**
 * Interface définissant les props du composant PersonnageCard
 * @property {string} id - L'identifiant unique du personnage
 * @property {string} name - Le nom du personnage
 * @property {string} imageUrl - L'URL de l'image du personnage
 */
interface IPersonnageCardProps {
  id: string;
  name: string;
  imageUrl: string;
}

/**
 * Composant qui affiche une carte pour un personnage des Simpsons
 * @param {IPersonnageCardProps} props - Les propriétés du composant
 * @returns {JSX.Element} Le composant PersonnageCard
 */
export function PersonnageCard({ id, name, imageUrl }: IPersonnageCardProps) {
  // Hook pour la navigation
  const router = useRouter();

  // Fonction pour gérer le clic sur la carte
  const handleClick = () => {
    router.push(`/personnage/${id}`);
  };

  return (
    <Card
      className="w-[200px] cursor-pointer transition-transform hover:scale-105"
      onClick={handleClick}
    >
      <CardContent className="p-0">
        <div className="relative w-full h-[200px]">
          <Image
            src={imageUrl}
            alt={`Photo de ${name}`}
            fill
            className="object-cover rounded-t-lg"
          />
        </div>
      </CardContent>
      <CardFooter className="p-4">
        <h3 className="text-lg font-semibold text-center w-full">{name}</h3>
      </CardFooter>
    </Card>
  );
}
