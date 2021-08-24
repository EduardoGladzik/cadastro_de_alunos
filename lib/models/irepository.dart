abstract class IRepository<G> {
  Future<int> insert(G entity);
  
  Future<List<G>> search();

  Future<G> find(int id);

  Future<int> update({
    required G entity,
    required String condictions,
    required List condtionsValue,
  });

  Future<int> remove({
    required String conditions,
    required List conditionsValue,
  });
}