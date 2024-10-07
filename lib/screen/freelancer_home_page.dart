import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freela_app/screen/project_details_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:freela_app/models/project_model.dart';
// Mock data for projects
final projectsProvider = StateProvider<List<Project>>((ref) => [
  Project(id: 1, title: 'Desenvolvimento de Aplicativo Mobile',
    category: 'Desenvolvimento Mobile',
    minBudget: 10000,
    maxBudget: 15000,
    description: 'Procuramos um desenvolvedor experiente para criar um aplicativo móvel para iOS e Android usando React Native. O aplicativo será um marketplace para produtos artesanais.',
    skills: ['React Native', 'iOS', 'Android', 'API REST', 'Redux'],
    publishedDate: DateTime(2023, 6, 15),
    deadline: 45,
    workType: 'Remoto',
    clientName: 'Maria Empreendedora',
    clientRating: 4.8,
    clientProjects: 12,),
  Project(id: 2, title: 'Desenvolvimento de E-Commerce',
    category: 'Desenvolvimento Web',
    minBudget: 15000,
    maxBudget: 25000,
    description: 'Procuramos um desenvolvedor experiente para criar um aplicativo móvel para iOS e Android usando React Native. O aplicativo será um marketplace para produtos artesanais.',
    skills: ['React', 'Next', 'Front-end', 'Full-Stack', 'API'],
    publishedDate: DateTime(2023, 6, 15),
    deadline: 60,
    workType: 'Remoto',
    clientName: 'Marcio Empreendedora',
    clientRating: 4.2,
    clientProjects: 12,),
]);

class FreelancerHomePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final searchController = useTextEditingController();
    final sortOption = useState('title');
    final filterOption = useState('all');

    List<Project> filteredAndSortedProjects = projects.where((project) {
      if (filterOption.value == 'all') return true;
      return project.minBudget >= (filterOption.value == 'high' ? 3000 : 0) &&
          project.maxBudget < (filterOption.value == 'high' ? double.infinity : 3000);
    }).toList();

    filteredAndSortedProjects.sort((a, b) {
      if (sortOption.value == 'title') {
        return a.title.compareTo(b.title);
      } else {
        return b.minBudget.compareTo(a.maxBudget);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Projetos Disponíveis', selectionColor: Colors.white,),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // TODO: Implement profile view
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar projetos',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(projectsProvider.notifier).state = projects.where((project) =>
                project.title.toLowerCase().contains(value.toLowerCase()) ||
                    project.description.toLowerCase().contains(value.toLowerCase())).toList();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: sortOption.value,
                  items: [
                    DropdownMenuItem(value: 'title', child: Text('Ordenar por Título')),
                    DropdownMenuItem(value: 'budget', child: Text('Ordenar por Orçamento')),
                  ],
                  onChanged: (value) => sortOption.value = value!,
                ),
                DropdownButton<String>(
                  value: filterOption.value,
                  items: [
                    DropdownMenuItem(value: 'all', child: Text('Todos os Projetos')),
                    DropdownMenuItem(value: 'high', child: Text('Orçamento Alto')),
                    DropdownMenuItem(value: 'low', child: Text('Orçamento Baixo')),
                  ],
                  onChanged: (value) => filterOption.value = value!,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAndSortedProjects.length,
              itemBuilder: (context, index) {
                final project = filteredAndSortedProjects[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(project.title),
                    subtitle: Text(project.description),
                    trailing: Text('R\$ ${project.minBudget.toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailsPage(project: project),
                        ),
                      );
                    },

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}