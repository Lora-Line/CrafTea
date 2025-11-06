//
//  HobbyViewModel.swift
//  Craftea
//
//  Created by chatGPT on 28/10/2025.
//


import SwiftUI
import UIKit
import Observation

extension UIImage {
    /// Sauvegarde l'image dans le dossier Documents avec un nom donné
    func saveToDocuments(named name: String) -> URL? {
        guard let data = self.pngData() else { return nil }
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(name).png")
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Erreur sauvegarde image:", error.localizedDescription)
            return nil
        }
    }
    
    /// Charge une image depuis le dossier Documents par nom
    static func loadFromDocuments(named name: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(name).png")
        return UIImage(contentsOfFile: fileURL.path)
    }
}

@Observable
class HobbyViewModel {
    private let unsplash = UnsplashService(accessKey: "5bOGmrInQ06GBsAQMMD4OE8hN9S0J9QU9Y_ShBlgE6U")
    //private let unsplash = UnsplashService(accessKey: "")
    var hobbies: [Hobby] = []
    
    init() {
        hobbies = [   //La liste de tout nos hobbies
            
             Hobby(
             name: .PeintureAcrylique,
             description: "Créer des œuvres colorées et texturées",
             image: "acrylique",
             level: .easy,
             category: .peinture,
             equipementNeeded: [
             BaseEquipment(name: "Pinceaux", description: "Ensemble de pinceaux plats et ronds", image: "https://images.pexels.com/photos/7302093/pexels-photo-7302093.jpeg"),
             BaseEquipment(name: "Toile", description: "Toile montée ou panneau entoilé", image: "https://media.istockphoto.com/id/942992430/photo/empty-canvas-on-easel.jpg?s=612x612&w=0&k=20&c=DEjNV_QH42Fa7zvdYLDtMpNzpFx61cHofrdVtyiyX1w="),
             BaseEquipment(name: "Palette", description: "Pour mélanger les couleurs", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsQFveoasupOhaohg0yipt4YMkPDnH2wMWuQ&s"),
             BaseEquipment(name: "Peinture acrylique", description: "Jeu de couleurs primaires et secondaires", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3Il-pywHWe6lyU7dp8xbsSbkxws-UqtfYg&s"),
             BaseEquipment(name: "Eau et chiffon", description: "Nettoyage des pinceaux et corrections", image: ""),
             BaseEquipment(name: "Couteau à peindre", description: "Pour textures et mélanges", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDa5-FI3II-qLRFW2ZkGk_cco_jet8bpEJWg&s")
             ],
             technicalBasis: [
             Technique(name: "Aplat", but: "Obtenir une surface de couleur uniforme et opaque.", description: "Prépare ta couleur sur la palette, charge un pinceau plat, puis peins des bandes parallèles en chevauchant légèrement pour éviter les traces. Lisse rapidement avant séchage.", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyraUPwDfqu6ZkBDlPn8P3eojAauCVHwQ0xw&s"),
             Technique(name: "Empâtement", but: "Créer du relief et de la texture visibles.", description: "Prélève une grosse quantité d’acrylique avec un couteau à peindre et dépose-la en couches épaisses. Étale ou tapote pour former des crêtes et laisse sécher sans trop retravailler.", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjUu1tXlKgSmsQUaiDFTYtabDcKlWYAqA14g&s"),
             Technique(name: "Glacis", but: "Modifier subtilement la teinte et la lumière par transparence.", description: "Mélange la peinture avec un médium ou de l’eau pour obtenir une couche très transparente, puis passe-la uniformément sur une couche sèche. Répète pour intensifier.", image: "https://www.art-totale.com/wp-content/uploads/2018/08/Avant-glacis.jpg"),
             Technique(name: "Brossage à sec", but: "Souligner les reliefs et créer un effet texturé.", description: "Essuie presque entièrement le pinceau, prends un peu de peinture, puis frotte légèrement la surface en effleurant les reliefs pour ne teinter que les arêtes.", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5plr2kGOAA5nehfaVNaMTwqtlJ5fl_SgE7Q&s"),
             Technique(name: "Sous-couche", but: "Définir rapidement les valeurs et les grandes formes.", description: "Dilue la peinture et pose une première couche colorée sur toute la surface. Indique les zones claires/sombres et les volumes avant les détails.", image: nil)
             ], popular: true
             ),

             Hobby(
             name: .Aquarelle,
             description: "Peindre avec légèreté et transparence",
             image: "aquarelle",
             level: .medium,
             category: .peinture,
             equipementNeeded: [
             BaseEquipment(name: "Papiers aquarelle", description: "Papier 300 g/m²", image: ""),
             BaseEquipment(name: "Pinceaux à lavis", description: "Pinceaux souples pour lavis", image: ""),
             BaseEquipment(name: "Godets ou tubes aquarelle", description: "Peintures de base", image: ""),
             BaseEquipment(name: "Palette", description: "Mélange et dilution", image: ""),
             BaseEquipment(name: "Ruban adhésif", description: "Fixer le papier et éviter les gondolages", image: "")
             ],
             technicalBasis: [
             Technique(name: "Lavis", but: "Poser une teinte légère et homogène.", description: "Mouille ton pinceau, dilue fortement la couleur et applique-la en aplat régulier sur papier incliné. Éponge les surplus pour éviter les auréoles.", image: nil),
             Technique(name: "Dégradé", but: "Passer progressivement d’une couleur à une autre.", description: "Pose deux couleurs voisines sur papier humide, puis travaille la zone de jonction en allers-retours doux pour fondre les teintes.", image: nil),
             Technique(name: "Mouillé sur mouillé", but: "Obtenir des transitions douces et des bords flous.", description: "Humidifie le papier, charge ton pinceau et dépose la couleur sur la zone humide. Laisse les pigments se diffuser naturellement.", image: nil),
             Technique(name: "Mouillé sur sec", but: "Tracer des formes nettes et contrôlées.", description: "Attends que le papier soit complètement sec, puis peins avec peu d’eau pour garder des contours nets et précis.", image: nil),
             Technique(name: "Réserves", but: "Préserver des zones blanches intactes.", description: "Applique du liquide de masquage sur les zones à protéger. Peins librement autour, laisse sécher, puis retire le masque délicatement.", image: nil)
             ], popular: true
             ),
             Hobby(
             name: .Dessin,
             description: "Explorer le trait et les ombres",
             image: "dessin",
             level: .easy,
             category: .dessin,
             equipementNeeded: [
             BaseEquipment(name: "Crayons graphite", description: "Différentes duretés (HB, 2B, 4B)", image: ""),
             BaseEquipment(name: "Fusain", description: "Pour ombrages profonds", image: ""),
             BaseEquipment(name: "Gomme mie de pain", description: "Gomme douce pour estomper", image: ""),
             BaseEquipment(name: "Estompe", description: "Fondre les ombres", image: ""),
             BaseEquipment(name: "Bloc dessin", description: "Papier lisse ou grain fin", image: "")
             ],
             technicalBasis: [
             Technique(name: "Hachures", but: "Créer des ombres et des textures par lignes.", description: "Trace des séries de lignes parallèles régulières, puis croise-les pour foncer. Varie l’espacement et la pression pour moduler la valeur.", image: nil),
             Technique(name: "Contour", but: "Définir la silhouette et les proportions justes.", description: "Esquisse légèrement les formes principales, vérifie les alignements et corrige avant d’appuyer sur les lignes finales.", image: nil),
             Technique(name: "Perspective", but: "Donner une impression d’espace crédible.", description: "Place l’horizon, fixe un ou plusieurs points de fuite et trace les lignes de construction en respectant la convergence.", image: nil),
             Technique(name: "Valeurs", but: "Structurer le volume par contrastes de clair-obscur.", description: "Choisis une source de lumière, établis 3–5 niveaux de gris et ombre progressivement en gardant une transition douce.", image: nil)
             ], popular: true
             ),
             Hobby(
             name: .PeintureGalet,
             description: "Décorer des pierres uniques et naturelles",
             image: "peintureGalet",
             level: .easy,
             category: .peinture,
             equipementNeeded: [
             BaseEquipment(name: "Galets", description: "Pierres lisses lavées", image: ""),
             BaseEquipment(name: "Peinture acrylique", description: "Peinture pour surfaces", image: ""),
             BaseEquipment(name: "Vernis", description: "Protection et finition", image: ""),
             BaseEquipment(name: "Feutres acryliques", description: "Détails fins", image: "")
             ],
             technicalBasis: [
             Technique(name: "Mini motifs", but: "Décorer le galet avec des motifs nets et réguliers.", description: "Utilise un pinceau fin ou un feutre acrylique, trace les repères au crayon, puis peins les motifs par couches fines en laissant sécher entre passes.", image: nil),
             Technique(name: "Pochoir", but: "Reproduire un motif proprement et rapidement.", description: "Fixe le pochoir sur le galet, tamponne la peinture avec peu de charge et retire-le verticalement pour éviter les bavures.", image: nil),
             Technique(name: "Pointillisme", but: "Créer des motifs et dégradés par points.", description: "Charge un outil à embout rond et dépose des points réguliers. Resserre l’espacement pour foncer et espace pour éclaircir.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Crochet,
             description: "Créer vêtements et accessoires en maille",
                image: "crochet",
             level: .medium,
             category: .textile,
             equipementNeeded: [
             BaseEquipment(name: "Crochet", description: "Crochet adapté à la laine", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYtlq3WTNOyfChZYhRLtHrHMF0f4NtDiYs_A&s"),
             BaseEquipment(name: "Laine", description: "Fil adapté (catégorie 4 recommandé)", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBzIbbw5IQJWP1eDZeqXqGfrzco_929gsC0Q&s"),
             BaseEquipment(name: "Marqueurs de maille", description: "Repérer les tours", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQco2jXl0rO_e20jUkSr6ucnlWaVHu-tUypmw&s"),
             BaseEquipment(name: "Aiguille à laine", description: "Rentrer les fils", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrN0zkil-DYpqyOA_-GOJDCy6FoZ16phNbFw&s"),
             ],
             technicalBasis: [
             Technique(name: "Maille serrée", but: "Obtenir un tissu dense et régulier.", description: "Fais un nœud coulant, pique dans la maille, ramène le fil et termine la maille serrée en gardant une tension constante.", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7RP60Z6srNzRgILRme3l_3HF0cQX4E9XHug&s"),
             Technique(name: "Bride", but: "Gagner en hauteur rapidement.", description: "Fais un jeté, pique, ramène le fil puis écoule les boucles par étapes pour former la bride.", image: nil),
             Technique(name: "Anneau magique", but: "Démarrer un ouvrage circulaire sans trou central.", description: "Enroule le fil autour des doigts, crochète le nombre de mailles dans l’anneau, puis serre le cercle en tirant sur le fil libre.", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPnbTXQ_MQU3VACTbOYah1vzQPyoH4OXsAw&s"),
             Technique(name: "Augmentations / diminutions", but: "Modeler la forme de l’ouvrage.", description: "Réalise deux mailles dans la même maille pour augmenter, ou saute/écoule ensemble des mailles pour diminuer selon le patron.", image: nil)
             ], popular: true
             ),
             Hobby(
             name: .Couture,
             description: "Fabriquer ou réparer ses propres vêtements",
                image: "couture",
             level: .hard,
             category: .textile,
             equipementNeeded: [
             BaseEquipment(name: "Machine à coudre", description: "Machine pour coudre rapidement", image: ""),
             BaseEquipment(name: "Tissus", description: "Tissus variés", image: ""),
             BaseEquipment(name: "Épingles / pinces", description: "Maintenir les pièces", image: ""),
             BaseEquipment(name: "Craie tailleur", description: "Reporter les repères", image: ""),
             BaseEquipment(name: "Découd-vite", description: "Corriger les erreurs", image: "")
             ],
             technicalBasis: [
             Technique(name: "Assemblage", but: "Relier proprement les pièces du vêtement.", description: "Épingle les bords endroit contre endroit, pique à la machine en suivant la marge, puis ouvre ou surfile les coutures.", image: nil),
             Technique(name: "Finitions", but: "Stabiliser et embellir les bords.", description: "Replie l’ourlet au fer, pique à la bonne distance et ajoute une surpiqûre régulière pour renforcer.", image: nil),
             Technique(name: "Patronage", but: "Obtenir des pièces ajustées à la taille.", description: "Prends les mesures, reporte-les sur le patron, ajoute les marges de couture et coupe avec précision.", image: nil),
             Technique(name: "Surfilage", but: "Empêcher l’effilochage des tissus.", description: "Passe les bords à la surjeteuse ou au point zigzag en gardant une tension régulière.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Poterie,
             description: "Façonner objets décoratifs à la main",
                image: "poterie",
             level: .medium,
             category: .modelage,
             equipementNeeded: [
             BaseEquipment(name: "Argile", description: "Pâte à modeler", image: ""),
             BaseEquipment(name: "Tour ou outils de modelage", description: "Outils pour former", image: ""),
             BaseEquipment(name: "Ébauchoirs", description: "Outils de modelage", image: ""),
             BaseEquipment(name: "Barbotine", description: "Coller les pièces", image: ""),
             BaseEquipment(name: "Éponge", description: "Lisser les surfaces", image: "")
             ],
             technicalBasis: [
             Technique(name: "Modelage main", but: "Former des volumes de base sans tour.", description: "Malaxe l’argile, façonne des boulettes ou boudins et assemble en lissant les jointures avec barbotine.", image: nil),
             Technique(name: "Cuisson", but: "Solidifier et vitrifier la pièce.", description: "Laisse sécher la pièce, enfourne selon la courbe recommandée et respecte les paliers de température.", image: nil),
             Technique(name: "Colombin", but: "Monter des parois avec des boudins réguliers.", description: "Roule des boudins, superpose-les en spirale, puis lisse l’intérieur et l’extérieur pour souder.", image: nil),
             Technique(name: "Plaque", but: "Construire des formes géométriques nettes.", description: "Étale des plaques à épaisseur régulière, coupe aux gabarits, puis assemble à la barbotine en renforçant les angles.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Bougies,
             description: "Créer des bougies parfumées personnalisées",
                image: "bougie",
             level: .easy,
             category: .diy,
             equipementNeeded: [
             BaseEquipment(name: "Cire", description: "Cire paraffine ou soja", image: ""),
             BaseEquipment(name: "Mèches", description: "Mèches adaptées", image: ""),
             BaseEquipment(name: "Thermomètre", description: "Contrôler la température", image: ""),
             BaseEquipment(name: "Parfums et colorants", description: "Personnalisation", image: ""),
             BaseEquipment(name: "Récipients", description: "Verres ou moules", image: "")
             ],
             technicalBasis: [
             Technique(name: "Fusion", but: "Obtenir une cire à la bonne température.", description: "Chauffe la cire au bain-marie, surveille au thermomètre et retire-la avant le point de fumée.", image: nil),
             Technique(name: "Coulée en contenant", but: "Remplir proprement les récipients.", description: "Fixe la mèche, verse la cire à la température de coulée, recentre la mèche et laisse refroidir lentement.", image: nil),
             Technique(name: "Démoulage", but: "Obtenir une pièce nette sans fissures.", description: "Attends la solidification complète, démoule en pressant légèrement et ébarbe les bavures.", image: nil)
             ], popular: false
             ),
             
             Hobby(
             name: .Broderie,
             description: "Décorer le tissu avec des fils colorés",
                image: "broderie",
             level: .medium,
             category: .textile,
             equipementNeeded: [
             BaseEquipment(name: "Aiguilles à broder", description: "Aiguilles adaptées", image: ""),
             BaseEquipment(name: "Tambour à broder", description: "Maintient le tissu tendu", image: ""),
             BaseEquipment(name: "Fils mouliné", description: "Coton DMC ou équivalent", image: ""),
             BaseEquipment(name: "Ciseaux broderie", description: "Pointes fines", image: "")
             ],
             technicalBasis: [
             Technique(name: "Point de tige", but: "Tracer des lignes décoratives fluides.", description: "Pique l’aiguille à intervalle régulier en suivant le motif, recouvrant légèrement les points pour un trait continu.", image: nil),
             Technique(name: "Point de croix", but: "Réunir des croix régulières pour un motif.", description: "Forme des croix en deux points diagonaux croisés, en respectant la tension du fil.", image: nil),
             Technique(name: "Point arrière", but: "Délimiter contours avec un trait net.", description: "Fais des petits points en revenant en arrière pour une ligne pleine et régulière.", image: nil),
             Technique(name: "Point de nœud", but: "Créer des petits reliefs décoratifs.", description: "Enroule le fil autour de l’aiguille puis pique près du point d’entrée en tirant doucement pour former un nœud.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Savons,
             description: "Fabriquer des savons naturels et uniques",
                image: "savon",
             level: .medium,
             category: .diy,
             equipementNeeded: [
             BaseEquipment(name: "Bases de savon", description: "Base melt & pour ou saponification", image: ""),
             BaseEquipment(name: "Moules", description: "Moules silicone", image: ""),
             BaseEquipment(name: "Soude caustique", description: "Saponification à froid (précautions)", image: ""),
             BaseEquipment(name: "Balance de précision", description: "Dosage exact", image: ""),
             BaseEquipment(name: "Gants et lunettes", description: "Sécurité", image: "")
             ],
             technicalBasis: [
             Technique(name: "Saponification", but: "Transformer les corps gras en savon.", description: "Mélange la soude et les huiles en respectant les proportions, chauffe doucement et laisse la réaction chimique s’effectuer.", image: nil),
             Technique(name: "Trace", but: "Atteindre la consistance idéale du mélange.", description: "Mélange jusqu’à ce que le liquide épaississe et laisse des traces visibles en surface sans se dissiper.", image: nil),
             Technique(name: "Marbrage", but: "Créer des motifs décoratifs dans le savon.", description: "Verse des couches de couleurs différentes et utilise un outil pour tracer des formes avant solidification.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Scrapbooking,
             description: "Mettre en scène ses souvenirs créatifs",
                image: "scrapbooking",
             level: .easy,
             category: .papeterie,
             equipementNeeded: [
             BaseEquipment(name: "Papiers décoratifs", description: "Feuilles imprimées", image: ""),
             BaseEquipment(name: "Ciseaux et colle", description: "Outils de découpe et collage", image: ""),
             BaseEquipment(name: "Massicot", description: "Découpe droite et nette", image: ""),
             BaseEquipment(name: "Tampons et encres", description: "Décorations", image: ""),
             BaseEquipment(name: "Coins photo", description: "Fixation non permanente", image: "")
             ],
             technicalBasis: [
             Technique(name: "Mise en page", but: "Organiser visuellement textes et images.", description: "Place photos et papiers en test, ajuste l’équilibre, puis colle en respectant marges et alignements.", image: nil),
             Technique(name: "Matting", but: "Mettre en valeur les photos par encadrements.", description: "Découpe des passe-partout, superpose-les sous la photo et colle en centrant.", image: nil),
             Technique(name: "Embossage", but: "Créer un relief net et durable.", description: "Tamponne à l’encre, saupoudre la poudre à embosser, retire l’excédent puis chauffe jusqu’à fusion.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Origami,
             description: "Plier le papier pour créer des formes",
                image: "origami",
             level: .easy,
             category: .papier,
             equipementNeeded: [
             BaseEquipment(name: "Papier origami", description: "Feuilles prédécoupées", image: ""),
             BaseEquipment(name: "Plioir", description: "Marquer les plis", image: ""),
             BaseEquipment(name: "Papier kami", description: "Fin et robuste", image: "")
             ],
             technicalBasis: [
             Technique(name: "Pliage de base", but: "Réaliser des plis nets et précis.", description: "Marque le pli avec un plioir, plie selon vallée ou montagne et aligne soigneusement les bords.", image: nil),
             Technique(name: "Base de l'oiseau", but: "Préparer la structure pour des modèles d’oiseaux.", description: "Suis la séquence: base carrée, plis en pétale et enfoncements selon le diagramme jusqu’à obtenir la base.", image: nil),
             Technique(name: "Base de la grenouille", but: "Obtenir la base nécessaire aux modèles de grenouille.", description: "À partir d’un carré, réalise la base préliminaire puis les enfoncements pour former la base de grenouille.", image: nil)
             ], popular: true
             ),
             Hobby(
             name: .Bijoux,
             description: "Assembler perles et matériaux pour s’exprimer",
                image: "bijoux",
             level: .medium,
             category: .accessoires,
             equipementNeeded: [
             BaseEquipment(name: "Perles", description: "Perles de différentes tailles", image: ""),
             BaseEquipment(name: "Fil et outils", description: "Fil, pinces, fermoirs", image: ""),
             BaseEquipment(name: "Pinces plates et coupantes", description: "Travail des apprêts", image: ""),
             BaseEquipment(name: "Fils / câbles", description: "Montage et solidité", image: ""),
             BaseEquipment(name: "Tapis de perlage", description: "Éviter que les perles roulent", image: "")
             ],
             technicalBasis: [
             Technique(name: "Montage", but: "Construire des bijoux solides et propres.", description: "Enfile les perles, forme des boucles régulières avec la pince et ferme les anneaux sans les vriller.", image: nil),
             Technique(name: "Boucles et anneaux", but: "Créer des attaches symétriques et robustes.", description: "Coupe à la bonne longueur, forme une boucle avec la pince ronde et referme bord à bord.", image: nil),
             Technique(name: "Tissage de perles", but: "Obtenir un motif régulier et serré.", description: "Suis le schéma, tends le fil de manière constante et sécurise chaque rang par un demi-nœud discret.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Macrame,
             description: "Tisser des nœuds pour objets décoratifs",
                image: "macrame",
             level: .easy,
             category: .textile,
             equipementNeeded: [
             BaseEquipment(name: "Corde", description: "Corde coton ou jute", image: ""),
             BaseEquipment(name: "Support", description: "Bâton ou anneau pour suspendre", image: ""),
             BaseEquipment(name: "Peigne", description: "Brosser les franges", image: ""),
             BaseEquipment(name: "Ciseaux", description: "Coupe propre", image: "")
             ],
             technicalBasis: [
             Technique(name: "Nœuds de base", but: "Former des motifs stables en macramé.", description: "Monte les cordes, alterne nœud plat et demi-noeud en gardant une tension égale pour un rendu régulier.", image: nil),
             Technique(name: "Noeud torsadé", but: "Créer une corde torsadée uniforme.", description: "Répète des demi-nœuds du même côté pour former une torsade régulière.", image: nil),
             Technique(name: "Noeud d'alouette", but: "Fixer solidement les brins au support.", description: "Plie la corde en deux, passe la boucle autour du support et ramène les brins dans la boucle en serrant.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .DessinNumerique,
             description: "Créer des œuvres sur tablette ou PC",
                image: "dessinNumerique",
             level: .medium,
             category: .numerique,
             equipementNeeded: [
             BaseEquipment(name: "Tablette graphique", description: "Tablette + stylet", image: ""),
             BaseEquipment(name: "Logiciel de dessin", description: "Procreate, Photoshop, etc.", image: ""),
             BaseEquipment(name: "Gants anti-friction", description: "Glisse sur la tablette", image: ""),
             BaseEquipment(name: "Brosses numériques", description: "Packs de pinceaux", image: "")
             ],
             technicalBasis: [
             Technique(name: "Calques", but: "Travailler non destructivement par couches.", description: "Crée des calques séparés, nomme-les et utilise des masques pour isoler les modifications.", image: nil),
             Technique(name: "Rendu", but: "Simuler lumière et matériaux crédibles.", description: "Pose une lumière principale, ajoute ombres et reflets en respectant les volumes et la matière.", image: nil),
             Technique(name: "Raccourcis clavier", but: "Accélérer le flux de travail.", description: "Assigne les outils clés aux raccourcis et pratique leur enchaînement pour limiter les interruptions.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Modelisation3D,
             description: "Concevoir et façonner des objets virtuels",
                image: "modelisation3D",
             level: .hard,
             category: .numerique,
             equipementNeeded: [
             BaseEquipment(name: "Logiciel 3D", description: "Blender, Maya, etc.", image: ""),
             BaseEquipment(name: "Ordinateur puissant", description: "GPU/CPU adapté", image: ""),
             BaseEquipment(name: "Souris 3D / trackball", description: "Navigation précise", image: ""),
             BaseEquipment(name: "Bibliothèques de textures", description: "Matériaux réalistes", image: "")
             ],
             technicalBasis: [
             Technique(name: "Modélisation", but: "Construire une géométrie propre et optimisée.", description: "Bloque les volumes, ajoute des boucles de soutien et nettoie les normales en gardant une topologie régulière.", image: nil),
             Technique(name: "UV mapping", but: "Déplier la surface pour texturer sans distorsion.", description: "Place des seams logiques, déplie, puis minimise l’étirement et emballe les îlots efficacement.", image: nil),
             Technique(name: "Subdivision / retopologie", but: "Lisser et optimiser pour l’animation ou le rendu.", description: "Applique subdivision avec parcimonie, puis refais une topologie propre en quads pour conserver les formes.", image: nil)
             ], popular: true
             ),
             Hobby(
             name: .Photomontage,
             description: "Transformer ou sublimer des images existantes",
                image: "photomontage",
             level: .medium,
             category: .numerique,
             equipementNeeded: [
             BaseEquipment(name: "Appareil photo / smartphone", description: "Pour prendre photos", image: ""),
             BaseEquipment(name: "Logiciel de retouche", description: "Photoshop, Affinity", image: ""),
             BaseEquipment(name: "Tablette graphique (optionnel)", description: "Détourage précis", image: ""),
             BaseEquipment(name: "Banques d'images", description: "Ressources libres de droits", image: "")
             ],
             technicalBasis: [
             Technique(name: "Masques et calques", but: "Combiner des images proprement.", description: "Crée des masques de fusion, peins en noir/blanc pour révéler/cacher et ajuste l’opacité des calques.", image: nil),
             Technique(name: "Détourage", but: "Isoler précisément un sujet.", description: "Utilise sélection d’objet, plume ou canaux, puis affine les bords avec le masque de sélection.", image: nil),
             Technique(name: "Corrections colorimétriques", but: "Équilibrer couleurs et contrastes.", description: "Ajuste niveaux/courbes sur calques d’ajustement et compare avant/après pour éviter la dérive.", image: nil)
             ], popular: true
             ),
             Hobby(
             name: .EcritureCreative,
             description: "Inventer des histoires et jouer avec les mots",
                image: "ecritureCreative",
             level: .easy,
             category: .ecriture,
             equipementNeeded: [
             BaseEquipment(name: "Cahier", description: "Carnet pour notes", image: ""),
             BaseEquipment(name: "Stylo", description: "Stylo confortable", image: ""),
             BaseEquipment(name: "Timer", description: "Sprints d'écriture", image: ""),
             BaseEquipment(name: "Applications de notes", description: "Organisation des idées", image: "")
             ],
             technicalBasis: [
             Technique(name: "Structure narrative", but: "Construire un récit clair et captivant.", description: "Définis le protagoniste, l’objectif, le conflit et l’arc en 3 actes avant d’écrire.", image: nil),
             Technique(name: "Brainstorming", but: "Explorer un large éventail d’idées.", description: "Note tout sans juger pendant un temps limité, puis regroupe par thèmes et sélectionne.", image: nil),
             Technique(name: "Plan détaillé", but: "Guider l’écriture avec une feuille de route.", description: "Découpe en chapitres/scènes, liste objectifs, conflits et transitions pour chacun.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .Calligraphie,
             description: "Dessiner de belles lettres décoratives",
                image: "caligraphie",
             level: .medium,
             category: .ecriture,
             equipementNeeded: [
             BaseEquipment(name: "Plumes / feutres", description: "Outils pour lettering", image: ""),
             BaseEquipment(name: "Papier lisse", description: "Papier adapté", image: ""),
             BaseEquipment(name: "Encres", description: "Différentes viscosités", image: ""),
             BaseEquipment(name: "Guide-lignes", description: "Maintenir l'angle et la hauteur", image: "")
             ],
             technicalBasis: [
             Technique(name: "Contrôle du trait", but: "Obtenir des pleins et déliés maîtrisés.", description: "Maintiens un angle constant, appuie sur les descentes et allège sur les montées en suivant les ductus.", image: nil),
             Technique(name: "Ductus", but: "Tracer chaque lettre dans le bon ordre.", description: "Suis les flèches de construction, respecte le sens des traits et la vitesse constante.", image: nil),
             Technique(name: "Variations de pression", but: "Amplifier le contraste des lettres.", description: "Augmente la pression sur les traits descendants et relâche sur les ascendantes pour accentuer le rythme.", image: nil)
             ], popular: false
             ),
             Hobby(
             name: .JournalCreatif,
             description: "Organiser ses idées avec créativité visuelle",
                image: "journalCreatif",
             level: .easy,
             category: .papeterie,
             equipementNeeded: [
             BaseEquipment(name: "Bullet journal", description: "Carnet à point", image: ""),
             BaseEquipment(name: "Stickers et feutres", description: "Décorations", image: ""),
             BaseEquipment(name: "Règle et pochoirs", description: "Aider à tracer", image: ""),
             BaseEquipment(name: "Stickers / washi tape", description: "Décoration rapide", image: "")
             ],
             technicalBasis: [
             Technique(name: "Layouts", but: "Structurer les pages pour plus d’efficacité.", description: "Dessine des grilles, place titres et sections, et vérifie lisibilité et hiérarchie visuelle.", image: nil),
             Technique(name: "Habitudes et trackers", but: "Suivre ses routines facilement.", description: "Choisis un format (tableau, calendrier), définis des codes couleur et coche quotidiennement.", image: nil),
             Technique(name: "Lettrage", but: "Créer des titres lisibles et décoratifs.", description: "Esquisse au crayon, encre avec feutres adaptés et ajoute ombres/lumières pour le style.", image: nil)
             ], popular: false
             )
        ]
    }
    
    func loadDetailImages() async {
        /*.onAppear {  // a utiliser au dans la page ou on veut afficher les images
         Task {
         await viewModel.loadDetailImages(for: hobby)
         }
         }*/
        await withTaskGroup(of: Void.self) { group in
            for hobbyIndex in hobbies.indices {
                group.addTask(priority: .medium) { [weak self] in
                    guard let self = self else { return }
                    
                    let hobbyName = await self.hobbies[hobbyIndex].name.rawValue
                    let hobby = await self.hobbies[hobbyIndex]
                    
                    
                    // Images des équipements
                    for eqIndex in hobby.equipementNeeded.indices {
                        if hobby.equipementNeeded[eqIndex].image.isEmpty {
                            let eqName = hobby.equipementNeeded[eqIndex].name
                            let query = "\(eqName) \(hobbyName)"
                            let firstAttempt = await self.unsplash.fetchImageURL(for: query)
                            let secondAttempt = await self.unsplash.fetchImageURL(for: eqName)
                            if let url = firstAttempt ?? secondAttempt {
                                await MainActor.run {
                                    self.hobbies[hobbyIndex].equipementNeeded[eqIndex].image = url
                                }
                            }
                        }
                    }
                    
                    // Images des techniques
                    for tIndex in hobby.technicalBasis.indices {
                        let tech = hobby.technicalBasis[tIndex]
                        if tech.image?.isEmpty == true {
                            let query = "\(tech.name) \(hobbyName)"
                            let firstAttempt = await self.unsplash.fetchImageURL(for: query)
                            let secondAttempt = await self.unsplash.fetchImageURL(for: tech.name)
                            if let url = firstAttempt ?? secondAttempt {
                                await MainActor.run {
                                    self.hobbies[hobbyIndex].technicalBasis[tIndex].image = url
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

