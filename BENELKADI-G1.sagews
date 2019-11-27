︠5f22b481-ff54-4eeb-85a8-bb9b40c25997s︠


                                                        ##### BENELKADI Safouane El-Amine G1 #####
                                                                ##### Exercice 2 #####





def deconnectante(G, labels=True):
    if G.order() < 2 or not G.is_connected():
        return []

    B,C = G.blocks_and_cut_vertices()



    ME = set(G.multiple_edges(labels=False)) if G.allows_multiple_edges() else set()
    deco = list()
    for b in B:
        if len(b) == 2 and not tuple(b) in ME:
            if labels:
                if G.allows_multiple_edges():
                    [label] = G.edge_label(b[0], b[1])
                else:
                    label = G.edge_label(b[0], b[1])
                deco.append((b[0], b[1], label))
            else:
                deco.append(tuple(b))

    return deco

def orientation(G):
    print " \t\t\t Algorithme de calcul d'orientation en graphe fortement connexe ou d'arete deconnectante"
    print " \t\t\t\t\t\t BENELKADI    Safouane El-Amine   G1\n\n\n"
    if deconnectante(G) == []:
        dG = G.eulerian_orientation()
        print "\t\t\t *** Le graphe accepte une orientation en un graphe fortement connexe ***\n\n"
        print "\t\t *** Representation graphique du graphe passé en parametre : ***\n"
        G.show()
        print "\t\t *** Representation textuelle du graphe fortement connexe : ***\n"
        print "\n * Liste des sommets du graphes :\n\n", dG.vertices()
        print " * Liste des arcs sortants du graphes de X à Y tq: '(X , Y , w)' :\n\n", dG.outgoing_edges(dG.vertex_iterator() )
        print "\n\t\t *** Representation graphique du graphe fortement connexe : *** \n", dG.show()
        return
    
    print "\t\t\t *** Le graphe contient une(ou plusieurs) arete(s) deconnectante(s) ***\n\n"
    print " * Liste de(s) arete(s) deconnectante(s) du graphes :\n"
    return deconnectante(G)

                                                        #####          Exo 1 Q 1         #####






def connexite2(G):
    blocks = []
    cut_vertices = set()
    seen = set()
    for start in G.vertex_iterator():
        if start in seen:
            continue
           
        if not G.degree(start):
            blocks.append([start])
            seen.add(start)
            continue
            
        number = {}
        num = 1

        low_point = {}
        neighbors = {}
        
        stack = [start]
        edge_stack = []
        start_already_seen = False
        
        while stack:
            v = stack[-1]
            seen.add(v)


            if not v in number:

                number[v] = num
                neighbors[v] = G.neighbor_iterator(v)
                low_point[v] = num
                num += 1

            try:

                w = next(neighbors[v])


                if not w in number:
                    edge_stack.append((v,w))
                    stack.append(w)


                elif number[w]<number[v]:
                    edge_stack.append((v,w))
                    low_point[v] = min(low_point[v], number[w])


            except StopIteration:

                w = stack.pop()

                if not stack:
                    break

                v = stack[-1]


                low_point[v] = min(low_point[v], low_point[w])


                if low_point[w] >= number[v]:
                    new_block = set()
                    nw = number[w]
                    u1,u2 = edge_stack.pop()
                    while number[u1] >= nw:
                        new_block.add(u1)
                        u1,u2 = edge_stack.pop()
                    new_block.add(u1)

                    this_block = list(new_block)
                    blocks.append(this_block)


                    if (not v is start) or start_already_seen:
                        cut_vertices.add(v)
                    else:
                        start_already_seen = True
        print " \t\t\t\t\t\t Algorithme de calcul de composantes 2 connexe"
        print " \t\t\t\t\t\t\t BENELKADI Safouane El-Amine   G1\n\n\n"
        print "\t\t *** Representation graphique du graphe passé en parametre :  *** "
        G.show()
        print "\t\t *** Representation graphique des composantes 2-Connexe :  *** "
        L = list()
        for x in blocks:
            
            R = Graph()
            for y in x:
                for z in x:
                    if G.has_edge([ y , z ]): 
                        R.add_edge([y,z])
            L.append(R.edges())
            R.show()
           
        print "\t\t *** Representation textuelle des composantes 2-connexe : *** \n\n"
        
        print "\n * Liste des arete de chaque composante 2-connexe respectivement :\n\n", L
        print "\n\n"
	print "\n * Liste des sommets de chaque composante 2-connexe respectivement :\n"
        
        
        return blocks





                                                        #####          Exo 1 Q 2         #####







def deconnectante(G, labels=True):
    if G.order() < 2 or not G.is_connected():
        return []

    B,C = G.blocks_and_cut_vertices()



    ME = set(G.multiple_edges(labels=False)) if G.allows_multiple_edges() else set()
    my_bridges = list()
    for b in B:
        if len(b) == 2 and not tuple(b) in ME:
            if labels:
                if G.allows_multiple_edges():
                    [label] = G.edge_label(b[0], b[1])
                else:
                    label = G.edge_label(b[0], b[1])
                my_bridges.append((b[0], b[1], label))
            else:
                my_bridges.append(tuple(b))

    return my_bridges

def connexe_contenant_sommet(G, vertex, sort=True):


    try:
        c = list(G._backend.depth_first_search(vertex, ignore_direction=True))
    except AttributeError:
        c = list(G.depth_first_search(vertex, ignore_direction=True))

    if sort:
        c.sort()
    return c

def composantes_connexe(G, sort=True):
    
    seen = set()
    components = list()
    for v in G:
        if v not in seen:
            c = connexe_contenant_sommet(G, v, sort=sort)
            seen.update(c)
            components.append(c)
    components.sort(key=lambda comp: -len(comp))
    return components


def edgeconnexite2(H):
    G=H.copy()
    Bridges=deconnectante(G)
    G.delete_edges(Bridges)
    for x in G.vertices():
        if (G.degree(x)==0):
            G.delete_vertex(x)
    B=composantes_connexe(G)
    print " \t\t\t\t\t\t Algorithme de calcul de composantes 2 aretes connexe"
    print " \t\t\t\t\t\t\t BENELKADI Safouane El-Amine   G1\n\n\n"
    print "\t\t ***Representation graphique du graphe passé en parametre : ***"
    H.show()
    print "\t\t *** Representation graphique des composantes 2-Connexe : *** \n"
    L=list()
    for x in B:
            
        R = Graph()
        for y in x:
            for z in x:
                if G.has_edge([ y , z ]): 
                    R.add_edge([y,z])
        L.append(R.edges())
        R.show()
    print "\t\t *** Representation textuelle des composantes 2-connexe : ***\n"
        
    print "\n * Liste des arete de chaque composante 2-connexe respectivement :\n\n", L
    print "\n\n"
    print "\n * Liste des sommets de chaque composante 2-connexe respectivement :\n"
    return B






R = Graph()
R.add_edges([[0,1],[1,2],[2,3],[3,0],[3,4],[4,5],[5,6],[6,4],[6,7],[7,8],[8,6]]) # Pour tester exo 1
G = Graph()
G.add_edges([[4,5],[5,6],[6,4],[6,7],[7,8],[8,6]]) #  pour tester orientation


'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
'''                                                Fait Par BENELKADI Safouane El-Amine G1                                      '''
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
'''                                                          Exercice 1 Question 1                                              '''
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
connexite2(R)
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
'''                                                Fait Par BENELKADI Safouane El-Amine G1                                      '''
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
'''                                                          Exercice 1 Question 2                                              '''
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
edgeconnexite2(R)
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
'''                                                Fait Par BENELKADI Safouane El-Amine G1                                      '''
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
'''                                                              Exercice 2                                                     '''
'''                            ********************************************************************************                 '''
'''                            ********************************************************************************                 '''
orientation(G)






︡3f831d4d-8a73-47c9-8202-366fe53fe4ba︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                                                Fait Par BENELKADI Safouane El-Amine G1                                      '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                                                          Exercice 1 Question 1                                              '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":" \t\t\t\t\t\t Algorithme de calcul de composantes 2 connexe\n \t\t\t\t\t\t\t BENELKADI Safouane El-Amine   G1\n\n\n\n\t\t *** Representation graphique du graphe passé en parametre :  *** \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_OgBEb5.svg","show":true,"text":null,"uuid":"3bdc915f-5f2e-4730-aa98-64eeb4d384dd"},"once":false}︡{"stdout":"\t\t *** Representation graphique des composantes 2-Connexe :  *** "}︡{"stdout":"\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_sVd3rh.svg","show":true,"text":null,"uuid":"6bb84619-f24f-41a5-9c7c-6fc55ba6d0ad"},"once":false}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_jSm3gH.svg","show":true,"text":null,"uuid":"5496c837-38e1-4bfc-b174-2c72deccf33e"},"once":false}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_O37ZUA.svg","show":true,"text":null,"uuid":"1520b455-10bf-443e-bf88-11bd1bc80356"},"once":false}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_73rmuJ.svg","show":true,"text":null,"uuid":"7dcdb203-50bf-4a45-adbd-6820298fe879"},"once":false}︡{"stdout":"\t\t *** Representation textuelle des composantes 2-connexe : *** \n\n"}︡{"stdout":"\n\n * Liste des arete de chaque composante 2-connexe respectivement :\n\n[[(6, 7, None), (6, 8, None), (7, 8, None)], [(4, 5, None), (4, 6, None), (5, 6, None)], [(3, 4, None)], [(0, 1, None), (0, 3, None), (1, 2, None), (2, 3, None)]]\n\n\n\n\n * Liste des sommets de chaque composante 2-connexe respectivement :\n\n[[8, 6, 7], [4, 5, 6], [3, 4], [0, 1, 2, 3]]\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                                                Fait Par BENELKADI Safouane El-Amine G1                                      '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                                                          Exercice 1 Question 2                                              '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":" \t\t\t\t\t\t Algorithme de calcul de composantes 2 aretes connexe\n \t\t\t\t\t\t\t BENELKADI Safouane El-Amine   G1\n\n\n\n\t\t ***Representation graphique du graphe passé en parametre : ***\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_uCJ_Tv.svg","show":true,"text":null,"uuid":"c732f14d-066d-401d-beb7-2ac8be1b7e59"},"once":false}︡{"stdout":"\t\t *** Representation graphique des composantes 2-Connexe : *** \n"}︡{"stdout":"\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_wSWfOq.svg","show":true,"text":null,"uuid":"d38e038d-f23f-4114-8686-06ad7f89c2da"},"once":false}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_8VjbRm.svg","show":true,"text":null,"uuid":"9d0c49cf-3cb5-473d-847f-3db451f14dbb"},"once":false}︡{"stdout":"\t\t *** Representation textuelle des composantes 2-connexe : ***\n"}︡{"stdout":"\n\n * Liste des arete de chaque composante 2-connexe respectivement :\n\n[[(4, 5, None), (4, 6, None), (5, 6, None), (6, 7, None), (6, 8, None), (7, 8, None)], [(0, 1, None), (0, 3, None), (1, 2, None), (2, 3, None)]]\n\n\n\n\n * Liste des sommets de chaque composante 2-connexe respectivement :\n\n[[4, 5, 6, 7, 8], [0, 1, 2, 3]]\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                                                Fait Par BENELKADI Safouane El-Amine G1                                      '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                                                              Exercice 2                                                     '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":"'                            ********************************************************************************                 '\n"}︡{"stdout":" \t\t\t Algorithme de calcul d'orientation en graphe fortement connexe ou d'arete deconnectante\n \t\t\t\t\t\t BENELKADI    Safouane El-Amine   G1\n\n\n\n\t\t\t *** Le graphe accepte une orientation en un graphe fortement connexe ***\n\n\n\t\t *** Representation graphique du graphe passé en parametre : ***\n\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_2edCRW.svg","show":true,"text":null,"uuid":"85787804-ca52-4636-a7b4-7594176caa9a"},"once":false}︡{"stdout":"\t\t *** Representation textuelle du graphe fortement connexe : ***\n"}︡{"stdout":"\n\n * Liste des sommets du graphes :\n\n[4, 5, 6, 7, 8]\n * Liste des arcs sortants du graphes de X à Y tq: '(X , Y , w)' :\n\n[(4, 5, None), (5, 6, None), (6, 4, None), (6, 7, None), (7, 8, None), (8, 6, None)]\n\n\t\t *** Representation graphique du graphe fortement connexe : *** \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e73155d9-7eb4-4316-a411-1876edb160c2/316/tmp_fDDv6H.svg","show":true,"text":null,"uuid":"4f9ee9d0-009b-441e-b05e-c747ec50071d"},"once":false}︡{"stdout":"None"}︡{"stdout":"\n"}︡{"done":true}









