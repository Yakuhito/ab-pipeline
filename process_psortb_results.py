import os, sys

lines = open("PSORTb-results.txt", "r").read().strip().split("\n")[1:]

confidence_threshold = 7.5

desirable_locations = [
    "Unknown",
    "Extracellular",
    "OuterMembrane",
    "Periplasmic",
]
undesirable_locations = [
    "Cytoplasmic",
    "CytoplasmicMembrane"
]

desirable_ids = []

for l in lines:
    e = l.split("\t")
    name, location, confidence = e[0], e[1], e[2]
    prot_id = name.split(" ")[0]

    if float(confidence) < confidence_threshold or location in desirable_locations:
        desirable_ids.append(prot_id)
        continue
    elif location in undesirable_locations:
        continue

    print(f"Unknown location: {location}")
    sys.exit(1)

print("Proteins matching criteria: ", len(desirable_ids))

open("location.tab","w").write("\n".join(desirable_ids))